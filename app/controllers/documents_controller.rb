require 'elan_parser_db_model'
require 'elan_parser_helper'
require 'elan_parser_happymapper'
require 'elan_parser_save_xml'
require 'elan_parser_build_xml'

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
    @selected_project = DocumentProject.find_by_document_id(params[:id]).project
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

    if (!params[:document].nil?)
      uploaded_io = params[:document][:file_name]
      @document = Document.new(:file_name => uploaded_io.original_filename)

      happymapper_document = ElanParser::XML::AnnotationDocument.parse(uploaded_io.read)

      @document.save
      ElanParser::Xml::Save.new(
        happymapper_document,
        uploaded_io.original_filename
      )

      project = Project.find_by_id(params[:project][:project_id])

      if (!project.nil?)
        DocumentProject.create(:document => @document, :project => project)
      end

      respond_to do |format|
        if @document.save and !project.nil?
          format.html { redirect_to @document, notice: 'Document was successfully created.' }
        else
          @document.errors.add :project, "can't be blank"
          format.html { render action: "new" }
        end
      end
    else
      #Reload the page with a new error
      @document = Document.new

      respond_to do |format|
        @document.errors.add :document, "must be chosen"
        format.html { render action: "new" }
      end
    end
  end

  def show
    @document = Document.find(params[:id])
    @projects = Project.all
    @selected_project = DocumentProject.find_by_document_id(params[:id]).project

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # PUT /documents/1
  def update
    @document = Document.find(params[:id])
    @projects = Project.all
    project = Project.find_by_id(params[:project][:project_id])

    if (!project.nil?)
      DocumentProject.find_by_project_id(params[:id]).destroy
      DocumentProject.create(:project => project, :document => @document)
    end

    respond_to do |format|
      if @document.update_attributes(params[:document])
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
      else
        if (project.nil?)
          @document.errors.add :project, "can't be blank"
        end
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
    elan_xml = ElanParser::Xml::Build.new
		puts @document.file_name
    elan_xml.build_eaf_document(@document.file_name)
    send_data(elan_xml.elan_parser_xml, :filename => @document.file_name)
  end
end
