class RemoveAssetTables < ActiveRecord::Migration
  def up
    drop_table :assets
    drop_table :asset_types
  end

  def down
  end
end
