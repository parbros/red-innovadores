class TinymceAssetsController < ApplicationController
  def create
    
    file = File.new(params[:file].tempfile)
    uploader = CommentImageUploader.new
    uploader.store!(file)
    
    render json: {
      image: {
        url: uploader.to_s
      }
    }, content_type: "text/html"
  end
end