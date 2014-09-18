class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
  	@user = User.find(params[:id])
  end

  def like
      if params[:likeable_type] == "Post"
          @likeable = Post.find(params[:likeable_id])
      else
          @likeable = Comment.find(params[:likeable_id])
      end
  current_user.like!(@likeable)
  end
  def unlike
      if params[:likeable_type] == "Post"
          @likeable = Post.find(params[:likeable_id])
      else
          @likeable = Comment.find(params[:likeable_id])
      end
  current_user.unlike!(@likeable)
  end
end
