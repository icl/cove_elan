class Template < ActiveRecord::Base
  validates :user, :presence => true

	has_many :work_documents
  has_many :project_templates
  has_many :projects, :through => :project_templates

	belongs_to :document
	belongs_to :user

  def name_or_id
    return name.nil? ? 'Template ' + self.id.to_s : self.name
  end
end
