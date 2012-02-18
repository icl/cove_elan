require 'spec_helper'

describe "Dashboard" do

  describe "List of Documents for a Project" do
    describe "Each Document" do

      before :each do
        @document = Factory.create(:document)

        login_user
        visit '/'
       end
      it "has a link to download it" do
        within ".document-list-item" do
          page.should have_link File.basename(@document.eaf.to_s), :href => download_document_path( @document)
        end
      end
      it "has a link to view it online" do
        within ".document-list-item" do
          page.should have_link File.basename(@document.eaf.to_s), :href => document_path(@document)
        end
      end
    end
  end
end
