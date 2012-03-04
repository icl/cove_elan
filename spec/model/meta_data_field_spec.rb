require 'spec_helper'

describe :meta_data_field do
	before :each do
		@meta_data_field = Factory.create(:meta_data_field)
	end

	it "Should create a valid meta data field" do
		@meta_data_field.should be_valid
	end
end
