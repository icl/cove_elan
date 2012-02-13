require 'elan_parser_db_model'

class ElanParserDbDocumentsController < ApplicationController
  def index
    @documents = ElanParser::DB::Document.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /documents/1/edit
  def edit
    @document = ElanParser::DB::Document.find(params[:id])
  end

  # GET /documents/new
  def new
    @document = ElanParser::DB::Document.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # POST /documents
  def create
    @document = ElanParser::DB::Document.new(params[:elan_parser_db_document])

    respond_to do |format|
      if @document.save
        format.html { redirect_to @document, notice: 'Document was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def show
    @document = ElanParser::DB::Document.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # PUT /documents/1
  def update
    @document = ElanParser::DB::Document.find(params[:id])

    respond_to do |format|
      if @document.update_attributes(params[:elan_parser_db_document])
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /documents/1
  def destroy
    @document = ElanParser::DB::Document.find(params[:id])
    @document.destroy

    respond_to do |format|
      format.html { redirect_to elan_parser_db_documents_url }
    end
  end
end
