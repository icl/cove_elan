# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
CoveElan::Application.initialize!

# Add special inflector rules
ActiveSupport::Inflector.inflections do |inflect|
  inflect.irregular 'corpus', 'corpora'
end
