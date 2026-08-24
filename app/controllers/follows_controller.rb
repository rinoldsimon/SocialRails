class FollowsController < ApplicationController
  def create
    @user = User.find_by!(username: params[:user_username] || params[:username])
    @follow = current_user.active_follows.build(followed: @user)
    authorize @follow
    current_user.follow(@user)
    redirect_back fallback_location: user_path(@user)
  end

  def destroy
    @follow = current_user.active_follows.find(params[:id])
    authorize @follow
    @user = @follow.followed
    @follow.destroy
    redirect_back fallback_location: user_path(@user)
  end
end
