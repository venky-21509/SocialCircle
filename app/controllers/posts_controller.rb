class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:destroy]

  def index
    @posts = current_user.feed_posts
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to root_path, notice: 'Post was successfully created.'
    else
      @posts = current_user.feed_posts
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    if @post.user == current_user
      @post.destroy
      redirect_to root_path, notice: 'Post was successfully deleted.'
    else
      redirect_to root_path, alert: 'You can only delete your own posts.'
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
