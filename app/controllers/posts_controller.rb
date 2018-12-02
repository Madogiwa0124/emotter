class PostsController < ApplicationController
  def index
    @posts = params[:search] ? Post.search(search_params) : Post.all
    @tags = Post.top_tags
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    prepare_thumbnail
    prepare_post_images
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.assign_attributes(post_params)
    prepare_thumbnail
    prepare_post_images
    if @post.save
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def thumbnail
    post = Post.find(params[:id])
    send_data post.thumbnail, type: post.ctype, disposition: 'inline'
  end

  private

  def prepare_thumbnail
    temp_thumbnail = ImageBuilder::PostThumbnail.build(@post.title)
    @post.thumbnail = temp_thumbnail.tempfile.open.binmode.read
    @post.ctype = temp_thumbnail.mime_type
  end

  def prepare_post_images
    temp_images = ImageBuilder::PostImages.build(@post.body)
    @post.images.destroy_all
    temp_images.each { |image| @post.images.new(image: image.tempfile.open.binmode.read, ctype: image.mime_type) }
  end

  def post_params
    params.require(:post).permit(:title, :body, :tag_list)
  end

  def search_params
    params.require(:search).permit(:keyword, :tag)
  end
end
