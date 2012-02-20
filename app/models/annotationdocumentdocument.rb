require 'elan_parser'

class AnnotationDocumentDocument < ActiveRecord::Base
  belongs_to :annotation_document, :class => 'ElanParser::DB::AnnotationDocument'
  belongs_to :document

  validates :document, :annotation_document, :presence => true
end
