class CreateUserAssetAssignments < ActiveRecord::Migration
  def up
	remove_column :user_assets, :assetable_id
	remove_column :user_assets, :assetable_type

	create_table :user_asset_assignments do |t|
		t.belongs_to :user_asset
		t.references :user_asset_assignable, :polymorphic => true
	end
  end

  def down
  end
end
