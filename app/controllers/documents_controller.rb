require 'elan_parser'
class DocumentsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @documents = Document.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /documents/1/edit
  def edit
    @document = Document.find(params[:id])
    @projects = Project.all
    @selected_project = @document.project
  end

  # GET /documents/new
  def new
    @document = Document.new
    @projects = Project.all

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # POST /documents
  def create
    @projects = Project.all

    @document = Document.new(params[:document])

    if (!params[:project][:project_id].nil?) then
      @document.project_id = params[:project][:project_id]
      @selected_project = Project.find(params[:project][:project_id])
    end

    @document.create_annotation_document if @document.eaf?

    respond_to do |format|
      if @document.save
        format.html { redirect_to @document, notice: 'Document was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def show
    @document = Document.find(params[:id])
    @projects = Project.all
    @selected_project = @document.project

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # PUT /documents/1
  def update
    @document = Document.find(params[:id])
    @projects = Project.all

    respond_to do |format|
      if @document.update_attributes(params[:document])
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /documents/1
  def destroy
    @document = Document.find(params[:id])
    #destroyer = ElanParser::Helper::Destroyer.new
    #destroyer.destroy_children(@document.annotation_document)
    @document.destroy

    respond_to do |format|
      format.html { redirect_to documents_url }
    end
  end

  def download
    @document = Document.find(params[:id])
    elan_xml = ElanParser::XML::Build.new
    elan_xml.build_eaf_document(@document.annotation_document_id)
    send_data(elan_xml.elan_parser_xml, :filename => File.basename(@document.eaf.to_s))
  end
end
