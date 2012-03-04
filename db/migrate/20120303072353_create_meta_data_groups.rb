class CreateMetaDataGroups < ActiveRecord::Migration
  def change
    create_table :meta_data_groups do |t|
      t.column :name, :string
      t.references :meta_data_groupable, :polymorphic => true

      t.timestamps
    end
  end
end
