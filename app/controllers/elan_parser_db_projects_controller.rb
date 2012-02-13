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
  end

  # GET /projects/new
  def new
    @project = ElanParser::DB::Project.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # POST /projects
  def create
    @project = ElanParser::DB::Project.new(params[:elan_parser_db_project])

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def show
    @project = ElanParser::DB::Project.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # PUT /projects/1
  def update
    @project = ElanParser::DB::Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:elan_parser_db_project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
      else
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
