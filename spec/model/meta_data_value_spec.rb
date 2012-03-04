require 'spec_helper'

describe :meta_data_value do
	before :each do
		@meta_data_value = Factory.create(:meta_data_value)
	end

	it "Should create a valid meta data value" do
		@meta_data_value.should be_valid
	end
end
