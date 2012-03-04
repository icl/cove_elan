class Project < ActiveRecord::Base
  has_many :project_templates
  has_many :templates, :through => :project_templates

 	has_many :meta_data_values, :as => :meta_data_valuable, :dependent => :destroy
  has_one :meta_data_group, :as => :meta_data_groupable

  belongs_to :user
end
