class Project < ActiveRecord::Base
      validates :project_name, :description, :presence => true

      belongs_to :user
      
      has_many :corpora_projects
      has_many :corpora, :through => :corpora_projects

      has_many :document_project
      has_many :documents, :through => :document_project, :dependent => :destroy
end
