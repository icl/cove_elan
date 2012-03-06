require 'spec_helper'

describe "User Menu" do
  
  context "When a user is logged in" do
    before :each do
      login_user
    end

    it "should attempt to show a gravatar for that user" do
      within "#user-menu" do
        page.should have_css "img.avatar"
      end
    end
    it "should show the users email address" do
      within "#user-menu" do
        page.should have_content @user.email
      end
    end
    it "should show a sign out link" do
      within "#user-menu" do
        page.should have_content "Sign out"
      end
    end
  end

  context "When a user isn't logged in" do
    it "should show a sign in link" do
      visit  '/'
      within "#user-menu" do
        page.should have_css "#new_user"
      end
    end
    it "should show a sign up link"
  end
end
