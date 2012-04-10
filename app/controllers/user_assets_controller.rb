class UserAssetsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @user_assets = UserAsset.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @user_asset = UserAsset.find(params[:id])

    respond_to do |format|
      format.html {render}
      format.any {send_file @user_asset.file_name.path, :disposition => 'inline'}
    end
  end

  # GET /assets/new
  def new
    @user_asset = UserAsset.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def create
    @user_asset = UserAsset.new(:file_name => params[:user_asset][:file_name],
      :user_id => current_user.id,
      :content_type => params[:user_asset][:file_name].content_type,
      :headers => params[:user_asset][:file_name].headers)


    @user_asset.save
    
    respond_to do |format|
      if @user_asset.valid?
        puts @user_asset.inspect
        format.html { redirect_to @user_asset, notice: 'Asset was successfully saved.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def destroy
    UserAsset.find(params[:id]).destroy

    respond_to do |format|
      format.html { redirect_to user_assets_url }
    end
  end
end
