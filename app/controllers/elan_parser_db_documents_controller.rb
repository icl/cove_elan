require 'elan_parser_db_model'
require 'elan_parser_helper'
require 'elan_parser_happymapper'
require 'elan_parser_save_xml'
require 'elan_parser_build_xml'

class ElanParserDbDocumentsController < ApplicationController
  def index
    @documents = ElanParser::DB::Document.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /documents/1/edit
  def edit
    @document = ElanParser::DB::Document.find(params[:id])
    @projects = ElanParser::DB::Project.all
    @selected_project = ElanParser::DB::DocumentProject.find_by_document_id(params[:id]).project
  end

  # GET /documents/new
  def new
    @document = ElanParser::DB::Document.new
    @projects = ElanParser::DB::Project.all
    @selected_project = ElanParser::DB::Project.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # POST /documents
  def create
    @projects = ElanParser::DB::Project.all
    @selected_project = ElanParser::DB::Project.new

    if (!params[:elan_parser_db_document].nil?)
      uploaded_io = params[:elan_parser_db_document][:file_name]
      @document = ElanParser::DB::Document.new(:file_name => uploaded_io.original_filename)

      happymapper_document = ElanParser::XML::AnnotationDocument.parse(uploaded_io.read)

      @document.save
      ElanParser::Xml::Save.new(
        happymapper_document,
        @document
      )

      project = ElanParser::DB::Project.find_by_id(params[:project][:project_id])

      if (!project.nil?)
        ElanParser::DB::DocumentProject.create(:document => @document, :project => project)
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
      @document = ElanParser::DB::Document.new

      respond_to do |format|
        @document.errors.add :document, "must be chosen"
        format.html { render action: "new" }
      end
    end
  end

  def show
    @document = ElanParser::DB::Document.find(params[:id])
    @projects = ElanParser::DB::Project.all
    @selected_project = ElanParser::DB::DocumentProject.find_by_document_id(params[:id]).project

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # PUT /documents/1
  def update
    @document = ElanParser::DB::Document.find(params[:id])
    @projects = ElanParser::DB::Project.all
    project = ElanParser::DB::Project.find_by_id(params[:project][:project_id])

    if (!project.nil?)
      DocumentProject.find_by_project_id(params[:id]).destroy
      DocumentProject.create(:project => project, :document => @document)
    end

    respond_to do |format|
      if @document.update_attributes(params[:elan_parser_db_document])
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
    @document = ElanParser::DB::Document.find(params[:id])
    #destroyer = ElanParser::Helper::Destroyer.new
    #destroyer.destroy_children(@document.annotation_document)
    @document.destroy

    respond_to do |format|
      format.html { redirect_to elan_parser_db_documents_url }
    end
  end

  def download
    @document = ElanParser::DB::Document.find(params[:id])
    elan_xml = ElanParser::Xml::Build.new
    elan_xml.build_eaf_document(@document)
    send_data(elan_xml.elan_parser_xml, :filename => @document.file_name)
  end
end
