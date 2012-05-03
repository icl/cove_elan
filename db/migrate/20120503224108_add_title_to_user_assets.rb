class AddTitleToUserAssets < ActiveRecord::Migration
  def change
    add_column :user_assets, :title, :string

  end
end
