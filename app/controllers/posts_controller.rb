class PostsController < ApplicationController
  def index
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
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.attributes = post_params
    prepare_thumbnail
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

  def post_params
    params.require(:post).permit(:title, :body, :tag_list)
  end
end
