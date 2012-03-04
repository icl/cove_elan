class CreateMetadataFields < ActiveRecord::Migration
  def change
    create_table :meta_data_fields do |t|
      t.column :name, :string
      t.column :meta_data_field_type_id, :integer

      t.timestamps
    end
  end
end
