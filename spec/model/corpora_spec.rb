require 'spec_helper'

describe :corpora do


	before(:each) do
		@corpus = Factory.create(:corpus)
	end

	it "Should create a corpus" do
		@corpus.should be_valid
	end

  it "Should create a corpus with a document" do
    @corpus_work = Factory.create(:corpus_with_work)
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
