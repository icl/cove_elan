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

#		select_project_option
		attach_file('work_document[documents][eaf]', File.join(Rails.root, 'spec', 'fixtures', '02_09.eaf'))

		click_on('Create Work document')

		current_path.should == work_documents_path + "/" + WorkDocument.last.id.to_s
	end

	it "Should be invalid if you submit without a file" do
#		project = Factory.create(:project)

		visit('/work_documents/new')

#		select_project_option

		click_on('Create Work document')

		current_path.should == work_documents_path
	end

#	it "Should be invalid if you submit without a project" do
#		visit('/work_documents/new')
#
#		attach_file('work_document[documents][eaf]', File.join(Rails.root, 'spec', 'fixtures', '02_09.eaf'))
#
#		click_on('Create Work document')
#
#		current_path.should == work_documents_path
#	end

#	it "Should create and edit a work document" do
#		project = Factory.create(:project)
#		project_2 = Factory.create(:project)
#
#		visit('/work_documents/new')
#
#		#Find the second option and select it
#		select_project_option(option=3)
#
#		attach_file('work_document[documents][eaf]', File.join(Rails.root, 'spec', 'fixtures', '02_09.eaf'))
#
#		click_on('Create Work document')
#
#		visit(edit_work_document_path(WorkDocument.last))
#
#		click_on('Update Work document')
#
#		WorkDocument.last.project.id = project_2.id
#	end

#	def select_project_option(option=2)
#		second_option_xpath = "//*[@id='project_project_id']/option["+option.to_s+"]"
#		second_option = find(:xpath, second_option_xpath).text
#		select(second_option, :from => 'project[project_id]')
#	end
end
