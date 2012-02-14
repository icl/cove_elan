class Project < ActiveRecord::Base
      validates :project_name, :description, :presence => true

      belongs_to :user

	has_one :document, :dependent => :destroy

      has_many :document_project
      has_many :documents, :through => :document_project, :dependent => :destroy
end