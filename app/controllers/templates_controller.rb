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
    @meta_data_groups = @template.meta_data_group_assignments
    @meta_data_fields = MetaDataHelper.get_field_objects @template
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

    #Update meta data group assignments and field values
    @meta_data_groups = @template.meta_data_group_assignments
    
    MetaDataHelper.reset_group_assignments(@template, params[:template][:meta_data_group_ids])

    @meta_data_fields = MetaDataHelper.get_field_objects @template

    MetaDataHelper.validate_and_save_field_values @meta_data_fields, @template, params[:template][:meta_data_field]
    @template.name = params[:template][:name]

    #Update user asset assignments
	  UserAssetHelper.reset_user_asset_assignments(@template, params[:template][:user_asset_ids])

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

  def duplication
    @template = Template.find(params[:id])
    @duplicates = @template.overlapping_annotations
  end
end
