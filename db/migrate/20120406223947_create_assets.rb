class CreateAssets < ActiveRecord::Migration
  def up
		create_table :assets do |t|
			t.timestamps
			t.column :file_name, :string
			t.column :hash, :text
			t.references :assetable, :polymorphic => true
		end

		create_table :asset_types do |t|
			t.timestamps
			t.column :content_type, :string
			t.column :content_disposition, :string
			t.column :asset_type_name, :string
		end
  end

  def down
  end
end
