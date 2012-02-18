require 'spec_helper'

describe :corpora do
	before(:suite) do
		DatabaseCleaner.strategy = :transaction
		DatabaseCleaner.clean_with(:truncation)
	end

	before(:each) do
		DatabaseCleaner.start

		@project = Factory.create(:project)
	end

	after(:each) do
		DatabaseCleaner.clean
	end

	it "Should create a project" do
		@project.should be_valid
	end

	it "Should validate that a description exists" do
		@project.description = nil
		@project.should be_invalid
	end

	it "Should validate that a project name exists" do
		@project.project_name = nil
		@project.should be_invalid	
	end

	it "Should find documents bound to it" do
		document = Factory.create(:document)
		document.project.should be_valid
	end
end
