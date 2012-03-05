When /^I visit the home page$/ do
  visit root_path
end

When /^I fill in valid login credentials$/ do
  fill_in "Email", :with => User.first.email
  fill_in "Password", :with => "123456" 
end

When /^I sign in$/ do
  click_button "Sign in"
end

Then /^I should be signed in$/ do
  within "#user-menu" do
    page.should have_content "Sign out"
  end
end

Given /^I am signed in$/ do
  step "a user exists"
  step "I visit the home page"
  step "I fill in valid login credentials"
  step "I sign in"
  step "I should be signed in"
end

Given /^I fill in bad credentials$/ do
  fill_in "Email", :with => User.first.email
  fill_in "Password", :with => "thisistotallynotgoingtowork" 
end

Then /^I should get a bad sign in message$/ do
  within ".alert-error" do
    page.should have_content I18n.t 'devise.failure.invalid' 
  end
end

Then /^I should get a successful sign in message$/ do
  within ".alert-success" do
    page.should have_content I18n.t 'devise.sessions.signed_in'
  end
 end

Given /^I sign out$/ do
  within "#user-menu" do
    click_link "Sign out"
  end
end

Then /^I should get a sign out message$/ do
  within ".alert-success" do
    page.should have_content I18n.t 'devise.sessions.signed_out'
  end  
end
