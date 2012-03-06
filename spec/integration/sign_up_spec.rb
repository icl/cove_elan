require 'spec_helper'
describe "welcome page" do

  
  it "should allow me to sign in" do
    @user = Factory.create :user
    visit '/'

    within '#new_user' do
      fill_in 'user_email', with: @user.email
      fill_in "user_password", with: '123456'

      click_button "Sign in"
    end
    page.should have_content "Sign out"

  end
end
