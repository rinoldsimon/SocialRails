class UsersController < ApplicationController
  def index
    authorize User
    @query = params[:q].to_s.strip
    @users = User.order(:name)
    @users = @users.where("name ILIKE :q OR username ILIKE :q", q: "%#{@query}%") if @query.present?
  end

  def show
    @user = User.find_by!(username: params[:username])
    authorize @user
    @posts = @user.posts.newest.includes(:likes, comments: :user)
  end
end
