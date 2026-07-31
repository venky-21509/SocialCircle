class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show]

  def index
    @users = User.where.not(id: current_user.id).order(:username)
                   .includes(:accepted_follower_relationships, :accepted_followed_relationships)
  end

  def show
    @posts = @user.posts.includes(:likes, :comments).order(created_at: :desc)
  end

  def follow
    @user = User.find(params[:id])
    current_user.follow(@user)
    redirect_to @user, notice: "Follow request sent to #{@user.username}"
  end

  def unfollow
    @user = User.find(params[:id])
    current_user.unfollow(@user)
    redirect_to @user, notice: "You are no longer following #{@user.username}"
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
