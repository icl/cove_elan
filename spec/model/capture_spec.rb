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
      pending
      Capture.authorize_path(@capture_path)
      c = Capture.create(path: @capture_path)
      c.should be_valid
    end

    it "doesn't capture paths that haven't been authorized" do
      pending
      c = Capture.create(path: @capture_path)
      c.should_not be_valid
    end

  end

  context "capture a path full of files" do

    before :all do
      @capture_path = File.join(Rails.root, 'spec','fixtures')
      Capture.authorize_path(@capture_path)
    end

    after :all do
      Capture.authorized_paths = []
    end

    it "creates an Asset for each file" do
      cap = Capture.create(path: @capture_path)
      cap.acquire_contents
      cap.user_assets.should_not be_empty
    end
  end

  context "capturing a path that doesn't exist" 

  context "capturing an IO"

end
