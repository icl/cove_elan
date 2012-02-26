require 'elan_parser'
class DocumentsController < ApplicationController
  before_filter :authenticate_user!

  def download
    @document = Document.find(params[:id])
    elan_xml = ElanParser::XML::Build.new
    elan_xml.build_eaf_document(@document.annotation_document_id)
    send_data(elan_xml.elan_parser_xml, :filename => File.basename(@document.eaf.to_s))
  end
end
