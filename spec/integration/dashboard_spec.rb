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
          page.should have_link @document.file_name, :href => download_document_path( @document)
        end
      end
      it "has a link to view it online"
    end
  end
end
