require 'spec_helper'

describe :project do
	before :each do
		@project = Factory.create(:project)
	end

	it "Should create a valid project" do
		@project.should be_valid
	end
end
