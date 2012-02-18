require 'spec_helper'

Capybara.default_driver = :rack_test

describe "Documents Form" do
	include Capybara::DSL

	before :each do
		login_user
  end

	it "Should create a new document" do
		project = Factory.create(:project)

		visit('/documents/new')

		select_project_option
		attach_file('document[eaf]', File.join(Rails.root, 'spec', 'fixtures', '02_09.eaf'))

		click_on('Create Document')

		current_path.should == documents_path + "/" + Document.last.id.to_s
	end

	it "Should be invalid if you submit without a file" do
		project = Factory.create(:project)

		visit('/documents/new')

		select_project_option

		click_on('Create Document')

		current_path.should == documents_path
	end

	it "Should be invalid if you submit without a project" do
		project = Factory.create(:project)
		visit('/documents/new')

		attach_file('document[eaf]', File.join(Rails.root, 'spec', 'fixtures', '02_09.eaf'))

		click_on('Create Document')

		current_path.should == documents_path
	end

	it "Should create and edit a documents" do
		project = Factory.create(:project)
		project_2 = Factory.create(:project)

		visit('/documents/new')

		#Find the second option and select it
		select_project_option(option=3)

		attach_file('document[eaf]', File.join(Rails.root, 'spec', 'fixtures', '02_09.eaf'))

		click_on('Create Document')

		visit(edit_document_path(Document.last))

		click_on('Update Document')

		Document.last.project.id = project_2.id
	end

	def select_project_option(option=2)
		second_option_xpath = "//*[@id='project_project_id']/option["+option.to_s+"]"
		second_option = find(:xpath, second_option_xpath).text
		select(second_option, :from => 'project[project_id]')
	end
end
