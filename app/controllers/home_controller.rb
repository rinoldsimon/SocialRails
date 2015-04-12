class HomeController < ApplicationController
	before_action :authenticate_user!
	
  def index
  	@post = Post.new
  	#@posts = Post.all.paginate(page: params[:page], per_page: 3)
    @posts = Post.all
    respond_to do |format|
     format.html
     format.js
    end

  	@users = User.all
  end
end
