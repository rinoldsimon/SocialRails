class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    unless user_signed_in?
      @preview_posts = Post.newest.includes(:user, :likes, comments: :user).limit(3)
      render :welcome and return
    end

    @scope = params[:scope] == "following" ? :following : :square
    @post = Post.new
    @posts = Post.feed_for(current_user, scope: @scope).includes(:user, :likes, comments: :user)
    @suggested = User.where.not(id: current_user.id)
                     .where.not(id: current_user.following_ids)
                     .order(:name)
                     .limit(5)
  end
end
