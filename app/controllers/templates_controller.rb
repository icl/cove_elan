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

    respond_to do |format|
      if @template.update_attributes(params[:template])
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
