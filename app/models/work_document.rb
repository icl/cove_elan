class WorkDocument < ActiveRecord::Base
	after_create :async_template_identify

	has_one :document, :as => :documentable, :dependent => :destroy

	belongs_to :user

	accepts_nested_attributes_for :document

	belongs_to :template

  state_machine :initial => :waiting do

    event :process do
      transition :waiting => :processing
    end

    event :finish do
      transition :processing => :ready, :if => :document_processed?
      transition all => :failed
    end

    state :processing

  end

  def document_processed?
    document.valid?
  end

  def async_template_identify
    Resque.enqueue(TemplateIdentifer, self.id)
  end

	#belongs_to :project
	def clone_for_template
    elan_xml = ElanParser::XML::Build.new
    elan_xml.build_eaf_document(self.document.annotation_document_id)
		
		new_doc = Document.new(:eaf => self.document.eaf)

    new_doc.create_annotation_document if new_doc.eaf?

		new_doc.annotation_document.tiers.each { |t| t.annotations.each { |a| a.destroy } }

		new_doc.save

		template = Template.create(:document => new_doc, :user_id => self.user_id)

		return template
	end


	#Look thru the document media descriptors and tiers to identify if this template becomes a template or not
	def template_identify
		return if !self.document or !self.document.valid? or !self.template_id.nil?

		self_tiers = Array.new
		self_media = Array.new

		self.document.tiers.each { |t| self_tiers.push(t[:tier_id]) }
		self.document.media_descriptors.each { |m| self_media.push(m[:media_url]) }

		is_template = true

		# Determine if there is a document with an existing template
		Template.all.each do |t|
			wd = t.work_documents.first
			
			wd_tiers = Array.new
			wd_media = Array.new

			wd.document.tiers.each { |t| wd_tiers.push(t[:tier_id]) }
			wd.document.media_descriptors.each { |m| wd_media.push(m[:media_url]) }

			if (wd_tiers == self_tiers && wd_media == self_media)
					is_template = false
					self.template = t
					self.save
					break
			end
		end

		if (is_template)
			template = self.clone_for_template
			self.template = template
			self.save
		end
	end
end
