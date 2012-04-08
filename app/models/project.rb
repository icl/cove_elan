class Project < ActiveRecord::Base
  has_many :project_templates
  has_many :templates, :through => :project_templates

 	has_many :meta_data_values, :as => :meta_data_valuable, :dependent => :destroy
	has_many :meta_data_group_assignments, :as => :meta_data_group_assignable
	has_many :meta_data_groups, :through => :meta_data_group_assignments

  belongs_to :user
end
