require 'spec_helper'

describe "Index Access" do
  context "When not logged in" do
    it "is denied for projects" do
      visit projects_path
      current_path.should == new_user_session_path
    end
    it "is denied for templates" do
      visit templates_path
      current_path.should == new_user_session_path
    end
    it "is denied for work documents" do
      visit work_documents_path
      current_path.should == new_user_session_path
    end
    it "is denied for metadata fields" do
      visit meta_data_fields_path
      current_path.should == new_user_session_path
    end
    it "is denied for metadata groups" do
      visit meta_data_groups_path
      current_path.should == new_user_session_path
    end
  end
end
