class MetaDataHelper
  #Generate an array of meta data values for activerecord collection saving
  def self.map_field_values field_params, map_object
    #Create array of meta_data_fields based on the parameter name
    return if field_params.nil?

    field_params.each do |k, v|
      meta_data_field = MetaDataField.find_by_name(k)
      meta_data_field_type = meta_data_field.meta_data_field_type.field_type

      object_meta_data_value = MetaDataValue.where(
        :meta_data_field_id => meta_data_field.id,
        :meta_data_valuable_type => map_object.class.name,
        :meta_data_valuable_id => map_object.id)

      if object_meta_data_value.empty?
        result = map_object.meta_data_values.create(eval(":" + meta_data_field_type + "_value") => v,
          :meta_data_field => meta_data_field)
      else
        result = map_object.meta_data_values.find_by_meta_data_field_id(meta_data_field.id)
        result.update_attributes(eval(":" + meta_data_field_type + "_value") => v)
      end

      result.errors.each do |attr,msg|
        map_object.errors.add k, msg
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
end
