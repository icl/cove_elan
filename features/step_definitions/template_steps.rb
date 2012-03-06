When /^I edit a template$/ do
  visit edit_template_path(Template.first)
end

When /^I select a metadata group$/ do
  select "group_1", :from => :meta_data_group
  click_button "Update Template"
  click_link "Edit"

end

Then /^I should see fields for that group$/ do
  page.should have_content "Field 1"
end
