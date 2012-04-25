class MetaDataHelper
  def self.save_field_values field_id, group_id, map_object, value
    f = MetaDataField.find(field_id)
    g = MetaDataGroup.find(group_id)

    object_meta_data_value = map_object.meta_data_values.find_by_meta_data_group_id_and_meta_data_field_id(
      g.id,
      f.id)

      if object_meta_data_value.nil? then
        object_meta_data_value = MetaDataValue.create(eval(":" + f.meta_data_field_type.field_type + "_value") => value,
          :meta_data_field_id => f.id,
          :meta_data_group_id => g.id,
          :meta_data_valuable_type => map_object.class.name,
          :meta_data_valuable_id => map_object.id)
      else
        object_meta_data_value.update_attributes(eval(":" + f.meta_data_field_type.field_type + "_value") => value)
      end

      object_meta_data_value.errors.each do |attr,msg|
        map_object.errors.add f.name, msg
        f.errors.add f.name, msg
      end
  end

  def self.save_groups_and_fields meta_data_groups, map_object
    meta_data_groups.each do |g|
      meta_data_params = g[0].split('_')

      MetaDataHelper.save_field_values meta_data_params[1], meta_data_params[0], map_object, g[1]
    end
  end

  def self.get_field_value meta_data_field, map_object, meta_data_group
    value = MetaDataValue.where(:meta_data_group_id => meta_data_group.id,
      :meta_data_field_id => meta_data_field.id,
      :meta_data_valuable_type => map_object.class.name).first

    if value then
      field_type = meta_data_field.meta_data_field_type.field_type

      return eval('value.'+field_type+'_value')
    end

    return ""
  end

  def self.get_value_as_string meta_data_value
    type = MetaDataFieldType.find(meta_data_value.meta_data_field.meta_data_field_type_id).field_type

    return eval('meta_data_value.' + type + '_value.to_s')
  end

  def self.get_field_objects map_object
    meta_data_groups = {}

		if map_object.meta_data_group_assignments then
      map_object.meta_data_group_assignments.each do |assignment|
        field_objects = {}

        assignment.meta_data_group.meta_data_fields.each do |f|
          meta_data_value = assignment.meta_data_group.meta_data_values.find_by_meta_data_field_id(f.id)
				  meta_data_field_type = f.meta_data_field_type.field_type
				  field_objects[f.name] = [meta_data_value.nil? ? "" : eval('meta_data_value.'+meta_data_field_type+'_value'), f]
        end

        meta_data_groups[assignment.meta_data_group.name] = field_objects
      end
		end

    meta_data_groups = meta_data_groups.sort

    return meta_data_groups
  end

  def self.reset_group_assignments map_object, meta_data_group_assignments

    #Destroy existing assignments
    MetaDataGroupAssignment.where(:meta_data_group_assignable_id => map_object.id,
      :meta_data_group_assignable_type => map_object.class.name).each do |group|
        group.destroy
      end

    #Remove empty elements from input array
    meta_data_group_assignments.reject! { |e| e.empty? }

    #Create new assignments
    meta_data_group_assignments.each do |group|
      MetaDataGroupAssignment.create(:meta_data_group_id => group,
        :meta_data_group_assignable_type => map_object.class.name,
        :meta_data_group_assignable_id => map_object.id)
    end
  end
end
