class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  before_action :set_comment, only: [:destroy]

  def create
    @comment = @post.comments.build(comment_params.merge(user: current_user))
    if @comment.save
      redirect_to root_path, notice: 'Comment was successfully created.'
    else
      @posts = current_user.feed_posts
      @post = Post.new
      render 'posts/index', status: :unprocessable_entity
    end
  end

  def destroy
    if @comment.user == current_user
      @comment.destroy
      redirect_to root_path, notice: 'Comment was successfully deleted.'
    else
      redirect_to root_path, alert: 'You can only delete your own comments.'
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
