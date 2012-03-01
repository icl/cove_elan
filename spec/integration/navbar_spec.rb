require 'spec_helper'

describe "navbar" do

  context "when a user isn't signed in" do
    describe "Work Document Link" do
      it "redirects me to the sign in page" do
        visit '/'
        click_navbar_link "Work Documents"
        current_path.should == new_user_session_path
      end
    end
  end

  describe "when a user is signed in" do
      it "sends me to the work document list" do
        login_user
        click_navbar_link "Work Documents"
        current_path.should == work_documents_path
      end
  end
end

