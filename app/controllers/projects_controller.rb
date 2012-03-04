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
    @selected_meta_data_group = @project.meta_data_group
    @selected_templates = @project.templates
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

    @selected_meta_data_group = @project.meta_data_group
    @selected_templates = @project.templates

    @project.update_attributes(:name => params[:project][:name])

    MetaDataHelper.map_field_values params[:project][:meta_data_fields], @project

    @project.template_ids = params[:templates][:templates]

    @project.meta_data_group = MetaDataGroup.find(params[:meta_data_group][:meta_data_group_id]) unless params[:meta_data_group][:meta_data_group_id].empty?


    respond_to do |format|
      if @project.errors.count == 0 and @project.save
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
