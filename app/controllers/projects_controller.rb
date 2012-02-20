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
    @project = Project.new(params[:project])
    @corpora = Corpus.all

    unless (params[:corpus][:corpus_id].empty?)
      @project.corpus_id = params[:corpus][:corpus_id]
      @selected_corpus = Corpus.find(params[:corpus][:corpus_id])
    end

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def show
    @project = Project.find(params[:id])
    @corpora = Corpus.all
    @selected_corpus  = @project.corpus

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # PUT /projects/1
  def update
    @project = Project.find(params[:id])
    @corpora = Corpus.all

    @project.corpus_id = params[:corpus][:corpus_id]

    respond_to do |format|
      if @project.update_attributes(params[:project])
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
