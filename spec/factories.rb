FactoryGirl.define do

  factory :user do
    sequence( :first_name) { |n| "Testy#{n}"}
    sequence( :last_name) { |n| "McTesterson#{n}" }
    sequence( :email) {|n| "testy#{n}@gunpowder.ucsd.edu" }
    password "123456"
    password_confirmation "123456"
  end

  factory :document do
		eaf { File.open(File.join(Rails.root, 'spec', 'fixtures', '02_09.eaf')) }
		after_build do |obj|
			obj.create_annotation_document
		end
  end

  factory :project do
    sequence(:name) { |n| "project_#{n}" }
		association(:user)
  end

  factory :template do
    sequence(:name) { |n| "template_#{n}" }
    association(:document)
		association(:user)
  end

  factory :meta_data_field_type do
    field_type "string"
  end

  factory :meta_data_field do
    sequence(:name) { |n| "field_#{n}" }
    association(:meta_data_field_type)
  end

  factory :meta_data_value do
    string_value "Test String Value"
    association(:meta_data_field)
  end

  factory :meta_data_field_group do
    association(:meta_data_field)
    association(:meta_data_group)
  end

  factory :meta_data_group do
    sequence(:name) { |n| "group_#{n}" }
  end

	factory :work_document do
		association(:document)
		association(:user)
	end
end
