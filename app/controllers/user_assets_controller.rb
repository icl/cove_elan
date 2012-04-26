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
      format.any {send_file @user_asset.file_name.path}
    end
  end

  def edit
    @user_asset = UserAsset.find(params[:id])
    @meta_data_groups = @user_asset.meta_data_group_assignments
    @meta_data_fields = MetaDataHelper.get_field_objects @user_asset
  end

  # GET /assets/new
  def new
    @user_asset = UserAsset.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def update
    @user_asset = UserAsset.find(params[:id])

    MetaDataHelper.reset_group_assignments(@user_asset, params[:user_asset][:meta_data_group_ids])

    respond_to do |format|
      if @user_asset.errors.count == 0 and @user_asset.save
        format.html { redirect_to @user_asset, notice: 'Asset was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
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

  def download
    @user_asset = UserAsset.find(params[:id])
    send_file @user_asset.file_name.path
  end
end
