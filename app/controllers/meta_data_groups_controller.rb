class MetaDataGroupsController < ApplicationController
  # GET /meta_data_groups
  # GET /meta_data_groups.json
  def index
    @meta_data_groups = MetaDataGroup.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @meta_data_groups }
    end
  end

  # GET /meta_data_groups/1
  # GET /meta_data_groups/1.json
  def show
    @meta_data_group = MetaDataGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @meta_data_group }
    end
  end

  # GET /meta_data_groups/new
  # GET /meta_data_groups/new.json
  def new
    @meta_data_group = MetaDataGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @meta_data_group }
    end
  end

  # GET /meta_data_groups/1/edit
  def edit
    @meta_data_group = MetaDataGroup.find(params[:id])
  end

  # POST /meta_data_groups
  # POST /meta_data_groups.json
  def create
    @meta_data_group = MetaDataGroup.new(params[:meta_data_group])

    respond_to do |format|
      if @meta_data_group.save
        format.html { redirect_to @meta_data_group, notice: 'MetaData group was successfully created.' }
        format.json { render json: @meta_data_group, status: :created, location: @meta_data_group }
      else
        format.html { render action: "new" }
        format.json { render json: @meta_data_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /meta_data_groups/1
  # PUT /meta_data_groups/1.json
  def update
    @meta_data_group = MetaDataGroup.find(params[:id])

    respond_to do |format|
      if @meta_data_group.update_attributes(params[:meta_data_group])
        format.html { redirect_to @meta_data_group, notice: 'MetaData group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @meta_data_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meta_data_groups/1
  # DELETE /meta_data_groups/1.json
  def destroy
    @meta_data_group = MetaDataGroup.find(params[:id])
    @meta_data_group.destroy

    respond_to do |format|
      format.html { redirect_to meta_data_groups_url }
      format.json { head :no_content }
    end
  end
end
