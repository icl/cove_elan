require 'spec_helper'
require 'capybara/dsl'

describe "Dashboard" do

  describe "List of Documents for a Project" do
    describe "Each Document" do

      before :each do
        @work_document = Factory.create(:work_document)

        login_user
        visit '/'
       end
      it "has a link to download it" do
        within ".document-list-item" do
          page.should have_link File.basename(@work_document.document.eaf.to_s), 
						:href => download_document_path(@work_document.document)
        end
      end
      it "has a link to view it online" do
        within ".document-list-item" do
          page.should have_link File.basename(@work_document.document.eaf.to_s),
						:href => work_document_path(@work_document)
        end
      end
    end
  end
end
