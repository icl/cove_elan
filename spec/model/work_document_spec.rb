require 'spec_helper'

describe :work_document do
	before :each do
		@work_document = Factory.create(:work_document)
	end

	it "Should create a valid work_document from an eaf fixture" do
		@work_document.should be_valid
	end


  describe "States" do
    context "waiting" do
      it "should be marked as waiting to start" do
        WorkDocument.new.should be_waiting
      end

      it "should transition from waiting to processing" do
        doc = WorkDocument.new
        doc.stub(:async_template_identify)
        doc.process!
        doc.should be_processing
      end

      it "should not transition from waiting to ready" do
        doc = WorkDocument.new
        doc.stub(:async_template_identify)
        doc.process!
        doc.should_not be_ready
      end
    end
    context "processing" do
      before :each do 
        @doc = WorkDocument.new
        @doc.stub(:async_template_identify)
        @doc.process!
      end

      it "should transition from processing to ready" do
        @doc.stub(:document_processed?).and_return(true)
        @doc.finish!
        @doc.should be_ready
      end
      it "should not transition from processing to ready if processing fails" do
        @doc.stub(:document_processed?).and_return(false)
        @doc.finish!
        @doc.should_not be_ready
        @doc.should be_failed
      end
      it "should be in a failed state if processing fails" do
        @doc.stub(:document_processed?).and_return(false)
        @doc.finish!
        @doc.should_not be_ready
        @doc.should be_failed
      end
    end
  end
end
