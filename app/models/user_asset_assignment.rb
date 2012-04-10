class UserAssetAssignment < ActiveRecord::Base
	belongs_to :user_asset

	belongs_to :user_asset_assignable, :polymorphic => true
end
