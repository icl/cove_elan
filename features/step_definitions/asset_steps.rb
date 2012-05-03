require 'find'
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


Given /^COVE is authorized to scan "([^"]*)"$/ do |path|
  Capture.authorize_path(File.join("private", "data_sources",path))
end


Then /^"([^"]*)" should not be captured$/ do |capture_path|
   Capture.where(path: File.join("private", "data_sources", capture_path)).count.should == 0
  
end

Given /^I make a video asset$/ do
  a = UserAsset.create!( file_name: File.open(File.join(Rails.root, "private", "videos", "test.m4v")))
end


Given /^I navigate to its page$/ do
  visit user_asset_path(UserAsset.first.id)
  current_path.should ==  user_asset_path(UserAsset.first.id)
end

Then /^I should see the video$/ do
page.should have_xpath("//video/source[contains(@src, '#{user_asset_url(id: UserAsset.last.id, format: 'mp4' )}')]")
  

end

Then /^I should see the image$/ do

page.should have_xpath("//img[contains(@src, '#{user_asset_path(id: UserAsset.last.id, format: 'jpg' )}')]")
end

When /^I look at the page for an image asset$/ do
  a = UserAsset.create!( file_name: File.open(File.join(Rails.root, "private", "images", "test.jpg")))
  visit user_asset_path(a.id)
end


When /^I upload an asset$/ do
  step "I look at the page for an image asset"
end

When /^I mark it for review$/ do
  click_link "Edit"
  check("Needs Review")
  click_button("Update Asset")
end

Then /^it should it should be marked as needing review$/ do
  page.should have_content "Needs Review"
end



Then /^it should not be marked to be reviewed$/ do
  page.should_not have_content "Needs Review"
end

Given /^an asset that needs review$/ do
  step "I look at the page for an image asset"
  step "I mark it for review"
end


When /^I confirm that it has been reviewed$/ do
  click_link "Edit"
  uncheck("Needs Review")
  click_button("Update Asset")
end


