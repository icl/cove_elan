class Project < ActiveRecord::Base
  has_many :project_templates
  has_many :templates, :through => :project_templates
end
