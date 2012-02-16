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
    @selected_corpus  = CorpusProject.find_by_project_id(params[:id]).corpus
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

		complete = false

    corpus = Corpus.find_by_id(params[:corpus][:corpus_id])

    if (!corpus.nil?)
    	@project = Project.new(params[:project])
      CorpusProject.create(:corpus => corpus, :project => @project)
			if @project.save
				complete = true
			end
		else
      @project.errors.add :corpus, "can't be blank"
    end

    respond_to do |format|
      if complete == true
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def show
    @project = Project.find(params[:id])
    @corpora = Corpus.all
    @selected_corpus  = CorpusProject.find_by_project_id(params[:id]).corpus

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # PUT /projects/1
  def update
    @project = Project.find(params[:id])
    @corpora = Corpus.all

    corpus = Corpus.find_by_id(params[:corpus][:corpus_id])
    if (!corpus.nil?)
      CorpusProject.find_by_project_id(params[:id]).destroy
      CorpusProject.create(:corpus => corpus, :project => @project)
    end


    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
      else
        if (corpus.nil?)
          @project.errors.add :corpus, "can't be blank"
        end
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
