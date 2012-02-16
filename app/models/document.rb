class Document < ActiveRecord::Base
      validates :file_name, :presence => true

      belongs_to :user

			has_one :annotation_document, :dependent => :destroy

      has_many :document_project
      has_many :projects, :through => :document_project, :dependent => :destroy

      def base_name
        File.basename file_name, '.eaf'
      end
end
