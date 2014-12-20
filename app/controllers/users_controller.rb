class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @users = User.all
    if params[:search]
      @users = User.search(params[:search]).order("created_at DESC")
    else
      @users = User.all.order('created_at DESC')
    end
  end

  def show
  	@user = User.find(params[:id])
    @messages = @user.messages.all
    @message = @user.messages.build
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
