require 'spec_helper'

describe Document do

  it "should be able to check whether attached eaf file conforms to schema" do
    document = Document.new
    document.eaf = File.open(File.join(Rails.root, 'spec', 'fixtures', "02_04.eaf"))
    document.eaf_schema_errors.should be_empty
  end

  it "should not crash on schema validation if there is no eaf file" do
    document = Document.new
    lambda {
      document.eaf_schema_errors}.should_not raise_error
    
  end

  it "should be invalid if there is no eaf file" do
    document = Document.new
    document.should_not be_valid
  end

end
