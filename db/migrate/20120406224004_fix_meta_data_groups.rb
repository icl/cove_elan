class FixMetaDataGroups < ActiveRecord::Migration
  def up
		remove_column :meta_data_groups, :meta_data_groupable_id
		remove_column :meta_data_groups, :meta_data_groupable_type


		create_table :meta_data_group_assignments do |t|
			t.belongs_to :meta_data_group
			t.references :meta_data_group_assignable, :polymorphic => true
		end
  end

  def down
  end
end
