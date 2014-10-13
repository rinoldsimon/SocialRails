class HomeController < ApplicationController
	before_action :authenticate_user!
	
  def index
  	@post = Post.new
  	@posts = Post.all.paginate(page: params[:page], per_page: 3)

  	@users = User.all
  end
end
