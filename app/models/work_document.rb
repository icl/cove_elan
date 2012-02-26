class WorkDocument < ActiveRecord::Base
	validates :project, :presence => true
  validate :matches_project_tiers, :on => :save

	has_one :document, :as => :documentable, :dependent => :destroy

	accepts_nested_attributes_for :document

	belongs_to :project

  def matches_project_tiers
    return if self.project.nil? or !self.document.valid?

    project_tiers = Array.new
    self_tiers    = Array.new

    self.project.document.tiers.each { |x| project_tiers.push(x[:tier_id]) }
    self.document.tiers.each { |x| self_tiers.push(x[:tier_id]) }

    leftover_tiers = (project_tiers | self_tiers) - (project_tiers & self_tiers)

    errors.add :project_tier_validation, "Your document contains invalid tiers for this project." unless leftover_tiers.empty?
      (self_tiers-project_tiers).each do |lt|
        errors.add :invalid_tier, lt
      end
    end
end
