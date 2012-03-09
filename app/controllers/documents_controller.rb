require 'elan_parser'
class DocumentsController < ApplicationController
  before_filter :authenticate_user!

  def download
    @document = Document.find(params[:id])

		file_name = @document.related_template.name_or_id + "_" + @document.id.to_s + ".eaf"
		file_name = file_name.gsub(" ", "_")

    elan_xml = ElanParser::XML::Build.new
    elan_xml.build_eaf_document(@document.annotation_document_id)
    send_data(elan_xml.elan_parser_xml, :filename => File.basename(file_name))
  end
end
