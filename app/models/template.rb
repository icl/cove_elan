class Template < ActiveRecord::Base
  validates :user, :presence => true

	has_many :work_documents
  has_many :project_templates
  has_many :projects, :through => :project_templates

 	has_many :meta_data_values, :as => :meta_data_valuable, :dependent => :destroy
  has_one :meta_data_group, :as => :meta_data_groupable


	belongs_to :document, :dependent => :destroy
	belongs_to :user

  accepts_nested_attributes_for :meta_data_group

  def name_or_id
    return self.name.nil? ? 'Template ' + self.id.to_s : self.name
  end
end
