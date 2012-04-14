class FramesController < ApplicationController
 
  before_filter :authenticate_user!

  def index

    @user_asset = UserAsset.find(params[:user_asset_id])


#    if !(File.exists? "private/frames/#{params[:filename]}_#{params[:offset]}.jpg")
#    @frame = Avcrb::FrameRipper.new("private/videos/#{params[:filename]}.#{params[:extension]}",
#                                      :destination => "private/frames/#{params[:filename]}_#{params[:offset]}",
#                                      :offset => params[:offset],
#                                      :resolution => '360x200')
#    @frame.rip
#  end
  
 # send_file("private/frames/#{params[:filename]}_#{params[:offset]}.jpg")

  end

  def show
    @user_asset = UserAsset.find(params[:user_asset_id])
    render :text => "boom"
    
    @destination_path = File.join(Rails.root, "private", "frames", @user_asset.id.to_s, params[:id] + '.jpg')
        FileUtils.mkdir_p(File.dirname(@destination_path))

    if !(File.exists? @destination_path)
      @frame = Avcrb::FrameRipper.new( @user_asset.file_name.path,
                                      :destination => @destination_path.gsub('.jpg', '') ,
                                      :offset => params[:id],
                                      :resolution => "360x200")
      @frame.rip
    end

    respond_to do |format|

    
    format.jpeg {send_file(@destination_path, :disposition => "inline")}

    end
  end
end
