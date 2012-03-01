class WorkDocument < ActiveRecord::Base
	#validates :project, :presence => true
  #validate :matches_project_tiers, :on => :save
	validate :template_identify, :on => :create

	has_one :document, :as => :documentable, :dependent => :destroy
	belongs_to :user

	accepts_nested_attributes_for :document

	belongs_to :template

	#belongs_to :project


	private
	#Look thru the document media descriptors and tiers to identify if this template becomes a template or not
	def template_identify
		return unless self.document.valid?

		self_tiers = Array.new
		self_media = Array.new

		self.document.tiers.each { |t| self_tiers.push(t[:tier_id]) }
		self.document.media_descriptors.each { |m| self_media.push(m[:media_url]) }

		is_template = true
		template_id = 0

		WorkDocument.all.each do |work_document|
			if (work_document.id != self.id) then
				doc_tiers = Array.new
				doc_media = Array.new

				work_document.document.tiers.each { |t| doc_tiers.push(t[:tier_id]) }
				work_document.document.media_descriptors.each { |m| doc_media.push(m[:media_url]) }

				if (doc_tiers == self_tiers && doc_media == self_media)
					is_template = false
					template_id = work_document.template.id
				end
			end
		end

		if (is_template == true)
			self.template = Template.create()
		else
			self.template_id = template_id
		end

	end
end
