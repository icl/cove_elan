class AddCaptureIdToUserAssets < ActiveRecord::Migration
  def change
    add_column :user_assets, :capture_id, :integer

  end
end
