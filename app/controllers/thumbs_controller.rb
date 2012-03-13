class ThumbsController < ApplicationController
  def show
    if !(File.exists? "private/frames/#{params[:filename]}_#{params[:offset]}.jpg")
    @frame = Avcrb::FrameRipper.new("private/videos/#{params[:filename]}.#{params[:extension]}",
                                      :destination => "private/frames/#{params[:filename]}_#{params[:offset]}",
                                      :offset => params[:offset],
                                      :resolution => '360x200')
    @frame.rip
  end
  
  send_file("private/frames/#{params[:filename]}_#{params[:offset]}.jpg")

  end
end
