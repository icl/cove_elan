class MetaDataField < ActiveRecord::Base
  validates :meta_data_field_type, :name, :presence => true

  validates_length_of :name, :maximum => 255
  belongs_to :meta_data_field_type

  has_many :meta_data_field_groups
  has_many :meta_data_groups, :through => :meta_data_field_groups

	has_many :meta_data_values

  accepts_nested_attributes_for :meta_data_groups

end
