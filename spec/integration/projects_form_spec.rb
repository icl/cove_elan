require 'spec_helper'

Capybara.default_driver = :rack_test

describe "Projects Form" do
	include Capybara::DSL

	before :each do
		login_user
  end

	it "Should create a new project" do
		corpus = Factory.create(:corpus)
		visit('/projects/new')

		select_corpus_option
		fill_in('project[project_name]', :with => 'Test Project')
		fill_in('project[description]', :with => 'Test Description')

		click_on('Create Project')

		current_path.should == projects_path + "/" + Project.last.id.to_s
	end

	it "Should be invalid if you don't select a corpus" do
		corpus = Factory.create(:corpus)
		visit('/projects/new')

		fill_in('project[project_name]', :with => 'Test Project')
		fill_in('project[description]', :with => 'Test Description')

		click_on('Create Project')

		current_path.should == projects_path
	end

	it "Should be invalid if you submit without a name" do
		corpus = Factory.create(:corpus)

		visit('/projects/new')

		select_corpus_option
		fill_in('project_description', :with => 'Test Description')

		click_on('Create Project')

		current_path.should == projects_path
	end

	it "Should be invalid if you submit without a description" do
		corpus = Factory.create(:corpus)

		visit('/projects/new')

		select_corpus_option

		fill_in('project[project_name]', :with => 'Test Project')

		click_on('Create Project')

		current_path.should == projects_path
	end

	it "Should create and edit a projects" do
		corpus = Factory.create(:corpus)

		visit('/projects/new')

		select_corpus_option

		fill_in_project_form

		click_on('Create Project')

		visit(edit_project_path(Project.last))

		edit_project_name = 'Edited Project'
		edit_project_desc = 'Edited Project Description'

		fill_in('project[project_name]', :with => edit_project_name)
		fill_in('project[description]', :with => edit_project_desc)
	
		click_on('Update Project')

		Project.last.project_name.should == edit_project_name
		Project.last.description.should == edit_project_desc
	end

	def select_corpus_option
		second_option_xpath = "//*[@id='corpus_corpus_id']/option[2]"
		second_option = find(:xpath, second_option_xpath).text
		select(second_option, :from => 'corpus[corpus_id]')
	end

	def fill_in_project_form
		fill_in('project[project_name]', :with => 'Test Project')
		fill_in('project_description', :with => 'Test Description')
	end
end
