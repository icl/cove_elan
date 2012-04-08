class MetaDataGroupAssignment < ActiveRecord::Base
	belongs_to :meta_data_group

	belongs_to :meta_data_group_assignable, :polymorphic => true
end
