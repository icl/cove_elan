require 'spec_helper'
require 'capybara/dsl'

describe "Dashboard" do

  describe "List of Documents for a Template" do
    describe "Each Document" do

      before :each do
        login_user
        visit('/work_documents/new')
        attach_file('work_document[documents][eaf]', File.join(Rails.root, 'spec', 'fixtures', '02_09.eaf'))
        click_on('Create Work document')
        @work_document = WorkDocument.last
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

      it "has a link to view the template" do
        within ".page-header" do
          page.should have_link @work_document.template.name_or_id,
            :href => download_document_path(@work_document.template.document)
        end
      end

    end
  end
end
