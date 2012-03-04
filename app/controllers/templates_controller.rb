require 'elan_parser'
class TemplatesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @templates = Template.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /templates/1/edit
  def edit
    @template = Template.find(params[:id])
    @selected_meta_data_group = @template.meta_data_group
  end

  def show
    @template = Template.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # PUT /templates/1
  def update
    @template = Template.find(params[:id])
    @selected_meta_data_group = @template.meta_data_group

    MetaDataHelper.map_field_values params[:template][:meta_data_fields], @template

    @template.meta_data_group = MetaDataGroup.find(params[:meta_data_group][:meta_data_group_id]) unless params[:meta_data_group][:meta_data_group_id].empty?
    @template.name = params[:template][:name]

    respond_to do |format|
      if @template.errors.count == 0 and @template.save
        format.html { redirect_to @template, notice: 'Template was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /templates/1
  def destroy
    @template = Template.find(params[:id])
    @template.destroy

    respond_to do |format|
      format.html { redirect_to templates_url }
    end
  end
end
