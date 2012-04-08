require 'spec_helper'

Capybara.default_driver = :rack_test

describe "Work documents Form" do
	include Capybara::DSL

	before :each do
		login_user
  end

	it "Should create a new document" do
#		project = Factory.create(:project)

		visit('/work_documents/new')

		attach_file('work_document[documents][eaf]', File.join(Rails.root, 'spec', 'fixtures', '02_09.eaf'))

		click_on('Create Work document')

		current_path.should == work_documents_path + "/" + WorkDocument.last.id.to_s
	end

	it "Should be invalid if you submit without a file" do

		visit('/work_documents/new')

		click_on('Create Work document')

		current_path.should == work_documents_path
	end


end
