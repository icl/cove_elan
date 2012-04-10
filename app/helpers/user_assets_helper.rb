module UserAssetsHelper
  def display_asset(model)
    render :partial => "/user_assets/#{model.asset_type}"
  end
end
