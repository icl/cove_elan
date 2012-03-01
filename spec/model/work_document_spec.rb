require 'spec_helper'

describe :work_document do
	before :each do
		@work_document = Factory.create(:work_document)
	end

	it "Should create a valid work_document from an eaf fixture" do
		@work_document.should be_valid
	end
end
