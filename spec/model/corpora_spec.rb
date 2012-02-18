require 'spec_helper'

describe :corpora do
	before(:suite) do
		DatabaseCleaner.strategy = :transaction
		DatabaseCleaner.clean_with(:truncation)
	end

	before(:each) do
		DatabaseCleaner.start

		@corpus = Factory.create(:corpus)
	end

	after(:each) do
		DatabaseCleaner.clean
	end

	it "Should create a corpus" do
		@corpus.should be_valid
	end

	it "Should validate that a description exists" do
		@corpus.description = nil
		@corpus.should be_invalid
	end

	it "Should validate that a corpus name exists" do
		@corpus.name = nil
		@corpus.should be_invalid	
	end

	it "Should find projects bound to it" do
		project = Factory.create(:project)
		project.corpus.should be_valid
	end
end
