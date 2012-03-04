class MetaDataFieldsController < ApplicationController
  # GET /meta_data_fields
  # GET /meta_data_fields.json
  def index
    @meta_data_fields = MetaDataField.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @meta_data_fields }
    end
  end

  # GET /meta_data_fields/1
  # GET /meta_data_fields/1.json
  def show
    @meta_data_field = MetaDataField.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @meta_data_field }
    end
  end

  # GET /meta_data_fields/new
  # GET /meta_data_fields/new.json
  def new
    @meta_data_field = MetaDataField.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @meta_data_field }
    end
  end

  # GET /meta_data_fields/1/edit
  def edit
    @meta_data_field = MetaDataField.find(params[:id])
  end

  # POST /meta_data_fields
  # POST /meta_data_fields.json
  def create
    @meta_data_field = MetaDataField.new(params[:meta_data_field])

    respond_to do |format|
      if @meta_data_field.save
        format.html { redirect_to @meta_data_field, notice: 'MetaData field was successfully created.' }
        format.json { render json: @meta_data_field, status: :created, location: @meta_data_field }
      else
        format.html { render action: "new" }
        format.json { render json: @meta_data_field.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /meta_data_fields/1
  # PUT /meta_data_fields/1.json
  def update
    @meta_data_field = MetaDataField.find(params[:id])

    respond_to do |format|
      if @meta_data_field.update_attributes(params[:meta_data_field])
        format.html { redirect_to @meta_data_field, notice: 'MetaData field was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @meta_data_field.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meta_data_fields/1
  # DELETE /meta_data_fields/1.json
  def destroy
    @meta_data_field = MetaDataField.find(params[:id])
    @meta_data_field.destroy

    respond_to do |format|
      format.html { redirect_to meta_data_fields_url }
      format.json { head :no_content }
    end
  end
end
