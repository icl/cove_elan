class MetaDataValue < ActiveRecord::Base
  belongs_to :meta_data_valuable, :polymorphic => true
  belongs_to :meta_data_field
  belongs_to :meta_data_group

  validate { meta_data_is_valid }

  def associated_object
    association_id = self.meta_data_valuable_id
    association_object = self.meta_data_valuable_type

    return eval(association_object).find(association_id)
  end

  def meta_data_is_valid
    field_type = self.meta_data_field.meta_data_field_type.field_type

    if field_type == "string"
      validates_length_of :string_value, :maximum => 255, :message => "Maximum Length is 255"
    end

    if field_type == "integer"
      validates_numericality_of :integer_value, :message => "Integer required"
    end

  end
end
