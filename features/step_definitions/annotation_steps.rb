When /^I look at a work document$/ do
  Factory.create(:work_document)
  visit work_document_path(WorkDocument.first)
end

Then /^I should see a table of annotations$/ do
  within "table" do
    page.should have_content "O; Speaks to group on movement."
  end
end

Then /^an image of the tiers$/ do
  within "#viewer" do
    Nokogiri::HTML.parse(page.body).css('svg').should_not be_nil
  end
end


