require 'spec_helper'

describe "Dashboard" do

  describe "List of Documents for a Project" do
    describe "Each Document" do

      before :each do
        @document = Factory.create(:document)
       end
      it "has a link to download it" do
        login_user
        visit '/'

        within ".document-list-item" do
          page.should have_css "a"
        end
      end
      it "has a link to view it online"
    end
  end
end
