class CreateMetaDataFieldGroups < ActiveRecord::Migration
  def change
    create_table :meta_data_field_groups do |t|
      t.column :meta_data_field_id, :integer
      t.column :meta_data_group_id, :integer

      t.timestamps
    end
  end
end
