class AddUserAssets < ActiveRecord::Migration
  def up
    create_table :user_assets do |t|
      t.timestamps
      t.column :file_name, :string
      t.column :file_hash, :text
      t.references :assetable, :polymorphic => true
      t.column :content_type, :string
      t.column :headers, :text
      t.belongs_to :user
    end
  end

  def down
  end
end
