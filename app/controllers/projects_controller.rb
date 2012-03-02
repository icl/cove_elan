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
  end

  # GET /projects/new
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # POST /projects
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save!
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
    @project.update_attributes(:name => params[:project][:name])

    params[:project][:template_ids].each do |t|
      @project.templates << Template.find(t) if !t.empty? and @project.templates.find_by_id(t).nil?
    end

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
