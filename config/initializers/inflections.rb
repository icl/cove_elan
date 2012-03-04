# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format
# (all these examples are active by default):
# ActiveSupport::Inflector.inflections do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end
#
# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections do |inflect|
#   inflect.acronym 'RESTful'
# end

# Add special inflector rules
ActiveSupport::Inflector.inflections do |inflect|
  inflect.irregular 'corpus', 'corpora'
  inflect.irregular 'meta_data_field_type', 'meta_data_field_types'
  inflect.irregular 'meta_data_field', 'meta_data_fields'
  inflect.irregular 'meta_data_value', 'meta_data_values'
  inflect.irregular 'meta_data_field_group', 'meta_data_field_groups'
  inflect.irregular 'meta_data_group', 'meta_data_groups'
end
