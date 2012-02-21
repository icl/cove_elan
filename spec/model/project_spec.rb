require 'spec_helper'

describe :corpora do

	before(:each) do
		@project = Factory.create(:project)
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
