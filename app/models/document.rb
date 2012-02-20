require 'carrierwave/orm/activerecord'

class Document < ActiveRecord::Base
      validates :project, :eaf, :presence => true
      validate :annotation_document_is_valid, :on => :create

      belongs_to :user
      belongs_to :project
      belongs_to :annotation_document, :class_name => "ElanParser::DB::AnnotationDocument"

      mount_uploader :eaf, EafUploader

      def base_name
        File.basename file_name, '.eaf'
      end

      def create_annotation_document
        eaf_document = self.eaf.file.read
        @annotation_document = ElanParser::XML::Save.new(eaf_document, File.basename(self.eaf.to_s))
        self.annotation_document_id = @annotation_document.pkey_id
      end

      private
      def annotation_document_is_valid
        unless @annotation_document.nil?
          @annotation_document.validation_errors.each do |xsd_error|
            errors.add :xsd_validation, xsd_error.to_s
          end
        end
      end
end
