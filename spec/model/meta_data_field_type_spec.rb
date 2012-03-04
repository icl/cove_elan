require 'spec_helper'

describe :meta_data_field_type do
	before :each do
		@meta_data_field_type = Factory.create(:meta_data_field_type)
	end

	it "Should create a valid meta data field type" do
		@meta_data_field_type.should be_valid
	end
end
