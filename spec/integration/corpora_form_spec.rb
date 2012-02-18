require 'spec_helper'

Capybara.default_driver = :rack_test

describe "Corpora Form" do
	include Capybara::DSL

	before :each do
		login_user
  end

	it "Should create a new corpus" do
		visit('/corpora/new')

		fill_in('corpus[name]', :with => 'Test Corpus')
		fill_in('corpus_description', :with => 'Test Description')

		click_on('Create Corpus')

		current_path.should == corpora_path + "/" + Corpus.last.id.to_s
	end

	it "Should be invalid if you submit without a name" do
		visit('/corpora/new')

		fill_in('corpus_description', :with => 'Test Description')

		click_on('Create Corpus')

		current_path.should == corpora_path
	end

	it "Should be invalid if you submit without a description" do
		visit('/corpora/new')

		fill_in('corpus[name]', :with => 'Test Corpus')

		click_on('Create Corpus')

		current_path.should == corpora_path
	end

	it "Should create and edit a corpora" do
		visit('/corpora/new')

		fill_in('corpus[name]', :with => 'Test Corpus')
		fill_in('corpus_description', :with => 'Test Description')

		click_on('Create Corpus')

		visit(edit_corpus_path(Corpus.last))

		edit_corpus_name = 'Edited Corpus'
		edit_corpus_desc = 'Edited Corpus Description'

		fill_in('corpus[name]', :with => edit_corpus_name)
		fill_in('corpus[description]', :with => edit_corpus_desc)
	
		click_on('Update Corpus')

		Corpus.last.name.should == edit_corpus_name
		Corpus.last.description.should == edit_corpus_desc
	end
end
