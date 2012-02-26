require 'elan_parser'
class WorkDocumentsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @work_documents = WorkDocument.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /work_documents/1/edit
  def edit
    @work_document = WorkDocument.find(params[:id])
    @projects = Project.all
    @selected_project = @work_document.project
  end

  # GET /work_documents/new
  def new
    @work_document = WorkDocument.new
    @projects = Project.all

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # POST /work_documents
  def create
    @projects = Project.all
		@document = Document.new(:eaf => params[:work_document][:documents][:eaf])
		@work_document = WorkDocument.new(:document => @document, 
			:user_id => current_user.id, :project_id => params[:project][:project_id])

    unless (params[:project][:project_id].empty?) then
      @selected_project = Project.find(params[:project][:project_id])
    end

    @document.create_annotation_document if @document.eaf?

		@document.save
		@work_document.save

    respond_to do |format|
      if @work_document.valid?
        format.html { redirect_to @work_document, notice: 'Document was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def show
    @work_document = WorkDocument.find(params[:id])
    @projects = Project.all
    @selected_project = @work_document.project

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # PUT /work_documents/1
  def update
    @work_document = WorkDocument.find(params[:id])
    @projects = Project.all

    respond_to do |format|
      if @work_document.update_attributes(params[:project])
        format.html { redirect_to @work_document, notice: 'Work Document was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /work_documents/1
  def destroy
    @work_document = WorkDocument.find(params[:id])
    @work_document.destroy

    respond_to do |format|
      format.html { redirect_to work_documents_url }
    end
  end
end
