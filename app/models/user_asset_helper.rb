class UserAssetHelper

  def self.reset_user_asset_assignments map_object, user_asset_assignments

    #Destroy existing assignments
    UserAssetAssignment.where(:user_asset_assignable_id => map_object.id,
      :user_asset_assignable_type => map_object.class.name).each do |asset|
        asset.destroy
      end

    #Remove empty elements from input array
    user_asset_assignments.reject! { |e| e.empty? }

    #Create new assignments
    user_asset_assignments.each do |asset|
      UserAssetAssignment.create(:user_asset_id => asset,
        :user_asset_assignable_type => map_object.class.name,
        :user_asset_assignable_id => map_object.id)
    end
  end

end
