class MetaDataGroup < ActiveRecord::Base
  has_many :meta_data_field_groups
  has_many :meta_data_fields, :through => :meta_data_field_groups

	has_many :meta_data_group_assignments
	has_many :templates, :through => :meta_data_group_assignments, :source => :meta_data_group_assignable, :source_type => 'Template'
	has_many :projects, :through => :meta_data_group_assignments, :source => :meta_data_group_assignable, :source_type => 'Project'

	#Return a distinct list of assigned polymorphic types
  def related_objects
    related_objects = Array.new

		self.meta_data_group_assignments.uniq.each do |assignment|
			object_type = assignment.meta_data_group_assignable_type
			object_id = assignment.meta_data_group_assignable_id

			related_object = eval(object_type+'.find('+object_id.to_s+')')
			related_objects.push(related_object)
		end

		puts related_objects.inspect

    return related_objects
  end
end
