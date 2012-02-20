class Project < ActiveRecord::Base
      validates :corpus, :project_name, :description, :presence => true

      belongs_to :user
      belongs_to :corpus

      has_many :documents
end
