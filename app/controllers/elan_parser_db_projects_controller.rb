require 'elan_parser_db_model'

class ElanParserDbProjectsController < ApplicationController
  def index
    @projects = ElanParser::DB::Project.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /projects/1/edit
  def edit
    @project = ElanParser::DB::Project.find(params[:id])
    @corpora = Corpus.all
    @selected_corpus  = CorpusProject.find_by_project_id(params[:id]).corpus
  end

  # GET /projects/new
  def new
    @project = ElanParser::DB::Project.new

    #Get a list of corpora for this project to attach to.
    @corpora = Corpus.all
    @selected_corpus  = Corpus.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # POST /projects
  def create
    @project = ElanParser::DB::Project.new(params[:elan_parser_db_project])
    @corpora = Corpus.all
    @selected_corpus  = Corpus.new

    corpus = Corpus.find_by_id(params[:corpus][:corpus_id])

    if (!corpus.nil?)
      CorpusProject.create(:corpus => corpus, :project => @project)
    end

    donkey = "punch"

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
      else
        if (corpus.nil?)
          @project.errors.add :corpus, "can't be blank"
        end
        format.html { render action: "new" }
      end
    end
  end

  def show
    @project = ElanParser::DB::Project.find(params[:id])
    @corpora = Corpus.all
    @selected_corpus  = CorpusProject.find_by_project_id(params[:id]).corpus

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # PUT /projects/1
  def update
    @project = ElanParser::DB::Project.find(params[:id])
    @corpora = Corpus.all

    corpus = Corpus.find_by_id(params[:corpus][:corpus_id])
    if (!corpus.nil?)
      CorpusProject.find_by_project_id(params[:id]).destroy
      CorpusProject.create(:corpus => corpus, :project => @project)
    end


    respond_to do |format|
      if @project.update_attributes(params[:elan_parser_db_project])
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
    @project = ElanParser::DB::Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to elan_parser_db_projects_url }
    end
  end
end
