class MetaDataGroup < ActiveRecord::Base
  has_many :meta_data_field_groups
  has_many :meta_data_fields, :through => :meta_data_field_groups

	belongs_to :meta_data_groupable, :polymorphic => true

  #Return reflection objects outside of meta data fields and groups
  def related_objects
    invalid_reflections = ["meta_data_field_groups", "meta_data_fields"]

    related_objects = Array.new

    MetaDataGroup.reflect_on_all_associations.each do |a|
      unless invalid_reflections.include?(a.name.to_s)
        related_object = eval('self.' + a.name.to_s)
        related_objects.push(related_object) if related_object
      end
    end

    return related_objects
  end
end
