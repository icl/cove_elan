class ProjectTemplate < ActiveRecord::Base
  belongs_to :project
  belongs_to :template
end
