require 'spec_helper'

describe "navbar" do

  context "when a user isn't signed in" do
    describe "Projects Link" do
      it "redirects me to the sign in page" do
        visit '/'
        click_navbar_link "Projects"
        current_path.should == new_user_session_path
      end
    end
    describe "Corpora Link" do
      it "redirects me to the sign in page" do
        visit '/'
        click_navbar_link "Corpora"
        current_path.should == new_user_session_path
      end
    end

  end

  describe "when a user is signed in" do
    describe "Projects Link" do
      it "sends me to the project list" do
        login_user
        click_navbar_link "Projects"
        current_path.should == projects_path
      end
    end

    describe "Corpora Link" do
      it "sends me to the corpora list" do
        login_user
        click_navbar_link "Corpora"
        current_path.should == corpora_path
      end
    end
  end
end

