When /^I ask COVE to scan "([^"]*)"$/ do |capture_path|
  Capture.create(path: File.join("private", "data_sources", capture_path))
end

Then /^COVE should create record a capture for "([^"]*)"$/ do |capture_path|
  Capture.where(path: File.join("private", "data_sources", capture_path)).first.should_not be_nil 
end

Then /^create assets for any files in "([^"]*)"$/ do |capture_path|
   Capture.where(path: File.join("private", "data_sources", capture_path)).first
   .user_assets.count.should == Find.find(File.join("private", "data_sources", capture_path))
                                                .reject {|path| File.directory? path }.count
end
