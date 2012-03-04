class CreateMetaDataValues < ActiveRecord::Migration
  def change
    create_table :meta_data_values do |t|
      t.column :string_value, :string
      t.column :text_value, :text
      t.column :integer_value, :integer

      t.references :meta_data_valuable, :polymorphic => true
      t.belongs_to :meta_data_field

      t.timestamps
    end
  end
end
