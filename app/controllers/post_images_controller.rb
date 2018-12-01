class PostImagesController < ApplicationController
  def show
    post_image = PostImage.find(params[:id])
    send_data post_image.image, type: post_image.ctype, disposition: 'inline'
  end
end
