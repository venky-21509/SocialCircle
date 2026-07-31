class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @like = @post.likes.build(user: current_user)
    if @like.save
      redirect_to root_path, notice: 'Post liked!'
    else
      redirect_to root_path, alert: 'Unable to like post.'
    end
  end

  def destroy
    @like = @post.likes.find_by(user: current_user)
    if @like
      @like.destroy
      redirect_to root_path, notice: 'Post unliked.'
    else
      redirect_to root_path, alert: 'Like not found.'
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
