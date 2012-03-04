class MetaDataFieldGroup < ActiveRecord::Base
  belongs_to :meta_data_group
  belongs_to :meta_data_field
end
