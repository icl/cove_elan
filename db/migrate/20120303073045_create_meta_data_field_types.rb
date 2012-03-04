class CreateMetaDataFieldTypes < ActiveRecord::Migration
  def change
    create_table :meta_data_field_types do |t|
      t.string :field_type

      t.timestamps
    end
  end
end
