class ProjectsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @projects = Project.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
    @corpora = Corpus.all
    @selected_corpus  = @project.corpus
  end

  # GET /projects/new
  def new
    @project = Project.new

    #Get a list of corpora for this project to attach to.
    @corpora = Corpus.all

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # POST /projects
  def create
    @corpora = Corpus.all

		@document = Document.new(:eaf => params[:project][:documents][:eaf])

    @document.create_annotation_document if @document.eaf?

    @project = Project.new(:project_name => params[:project][:project_name], 
        :description => params[:project][:description],
        :user_id => current_user.id,
        :document => @document)

		@document.save
		
    unless (params[:corpus][:corpus_id].empty?)
      @project.corpus_id = params[:corpus][:corpus_id]
      @selected_corpus = Corpus.find(params[:corpus][:corpus_id])
    end

    @project.save

    respond_to do |format|
      if @project.valid?
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def show
    @project = Project.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # PUT /projects/1
  def update
    @project = Project.find(params[:id])
    @corpora = Corpus.all

    respond_to do |format|
      if @project.update_attributes(params[:project]) and @project.update_attributes(params[:corpus])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /projects/1
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
    end
  end
end
