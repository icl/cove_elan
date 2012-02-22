require 'spec_helper'

describe :video_group do
	before(:suite) do
		DatabaseCleaner.strategy = :transaction
		DatabaseCleaner.clean_with(:truncation)
	end

	before(:each) do
		DatabaseCleaner.start
	end

	after(:each) do
		DatabaseCleaner.clean
	end

	it "Should attach several template media descriptor sets to a corpus" do
		video_group = Factory.create(:video_group)
	end
end
