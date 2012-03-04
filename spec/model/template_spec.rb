require 'spec_helper'

describe :template do
	before :each do
		@template = Factory.create(:template)
	end

	it "Should create a valid template" do
		@template.should be_valid
	end
end
