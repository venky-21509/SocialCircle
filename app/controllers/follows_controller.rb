class FollowsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_follow

  def update
    if @follow.followed == current_user
      if params[:commit] == 'Accept'
        @follow.accept!
        redirect_to current_user, notice: 'Follow request accepted!'
      elsif params[:commit] == 'Reject'
        @follow.reject!
        redirect_to current_user, notice: 'Follow request rejected.'
      end
    else
      redirect_to current_user, alert: 'You cannot manage this follow request.'
    end
  end

  private

  def set_follow
    @follow = Follow.find(params[:id])
  end
end
