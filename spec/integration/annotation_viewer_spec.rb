require 'spec_helper'

describe "Annotation Viewer" do


  it "should create a table of annotations" do
    within "table" do
      page.should have_content "O; Speaks to group on movement."
    end
  end


 
end
