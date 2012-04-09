
Given /^I make a meta data field group named "([^"]*)"$/ do |group_name|
  step "I request a new meta data group"
  step %[I fill in a reasonable name like "#{group_name}"]
  step "I submit the group"
end


When /^I request a new meta data group$/ do
  visit meta_data_groups_path
  click_link "New"
end



When /^I fill in a reasonable name like "([^"]*)"$/ do |group_name|
  fill_in "Name", :with => group_name
end

When /^I submit the group$/ do
  click_button "Create Meta data group"
end

Then /^I should have a new metadata group named "([^"]*)"$/ do |group_name|
  MetaDataGroup.last.name.should == group_name
end


When /^I select metadata group "([^"]*)"$/ do |group_name|
  select group_name, :from => :meta_data_group
end

Then /^I should see fields group "([^"]*)"$/ do |group_name|
  page.should have_content group_name
end




