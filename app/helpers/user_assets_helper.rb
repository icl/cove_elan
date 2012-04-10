module UserAssetsHelper
  def display_asset(model)

    partial = "user_assets/#{model.asset_type}"

    if lookup_context.find_all("user_assets/_#{model.asset_type}").any?  
      render :partial => partial, :object => model
    else
      render :partial => 'unknown', :object => model
    end
  end
end
