require 'spec_helper'
describe "welcome page" do

  
  it "should allow me to sign in", :js => true do
    @user = Factory.create :user
    visit '/'

    within '#new_user' do
      fill_in 'Email', with: @user.email
      fill_in "Password", with: '123456'

      click_button "Sign in"
    end
    page.should have_content "Sign out"

  end
end
