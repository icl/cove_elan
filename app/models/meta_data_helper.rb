class MetaDataHelper
  def self.validate_and_save_field_values meta_data_fields, map_object, field_parameters
    return unless meta_data_fields
    meta_data_fields.each do |n, m|
      f = m[1]

      meta_data_field_type = f.meta_data_field_type.field_type

      object_meta_data_value = MetaDataValue.where(
        :meta_data_field_id => f.id,
        :meta_data_valuable_type => map_object.class.name,
        :meta_data_valuable_id => map_object.id)

        if object_meta_data_value.empty?
          result = map_object.meta_data_values.create(eval(":" + meta_data_field_type + "_value") => field_parameters[f.name],
            :meta_data_field => f)
        else
          result = map_object.meta_data_values.find_by_meta_data_field_id(f.id)
          result.update_attributes(eval(":" + meta_data_field_type + "_value") => field_parameters[f.name])
        end

        #Assign any field parameter values to the meta dat fields
        m[0] = field_parameters[f.name]

        result.errors.each do |attr,msg|
          map_object.errors.add f.name, msg
          f.errors.add f.name, msg
        end
    end
  end

  def self.get_field_values meta_data_field, map_object
    map_object.meta_data_values.each do |v|
      ft = v.meta_data_field.meta_data_field_type.field_type
      return eval('v.'+ft+'_value') if meta_data_field.name == v.meta_data_field.name
    end

    return nil
  end

  def self.get_field_objects map_object
    field_objects = {}

    map_object.meta_data_group.meta_data_fields.each do |f|
      meta_data_value = map_object.meta_data_values.find_by_meta_data_field_id(f.id)
      meta_data_field_type = f.meta_data_field_type.field_type

      field_objects[f.name] = [meta_data_value.nil? ? "" : eval('meta_data_value.'+meta_data_field_type+'_value'), f]
    end

    return field_objects
  end
end
