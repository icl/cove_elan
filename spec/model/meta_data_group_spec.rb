require 'spec_helper'

describe :meta_data_group do
	before :each do
		@meta_data_group = Factory.create(:meta_data_group)
	end

	it "Should create a valid meta data group" do
		@meta_data_group.should be_valid
	end

  it "Should associate a group and a field" do
    @meta_data_field_group = Factory.create(:meta_data_field_group)
    @meta_data_field_group.should be_valid
  end
end
