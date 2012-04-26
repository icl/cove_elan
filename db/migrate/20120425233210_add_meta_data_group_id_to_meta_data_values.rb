class AddMetaDataGroupIdToMetaDataValues < ActiveRecord::Migration
  def change
    add_column :meta_data_values, :meta_data_group_id, :integer
  end
end
