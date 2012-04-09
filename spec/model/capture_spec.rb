require 'spec_helper'

describe Capture do

  context "capturing only prespecified paths" do
    before :each do
      @capture_path = File.join(Rails.root, 'spec','fixtures')
      
    end

    after :each do
      Capture.authorized_paths = []
    end
    
    it "captures paths that it has been authorized too" do
      Capture.authorize_path(@capture_path)
      c = Capture.create(path: @capture_path)
      c.should be_valid
    end

    it "doesn't capture paths that haven't been authorized" do
      c = Capture.create(path: @capture_path)
      c.should_not be_valid
    end

  end

  context "capturing a path that doesn't exist" 

  context "capturing an IO"

end
