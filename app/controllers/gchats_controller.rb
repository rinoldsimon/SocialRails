class GchatsController < ApplicationController
	before_action :authenticate_user!

  def new
    @gchat = Gchat.new
    @gchats = Gchat.order('created_at DESC')
  end
 
  def create
  	if current_user
      @gchat = current_user.gchats.build(gchat_params)
    if @gchat.save
      flash[:success] = 'Your message was successfully posted!'
    else
      flash[:error] = 'Your message cannot be saved.'
    end
    end
  redirect_to root_url
  end

  private
 
  def gchat_params
    params.require(:gchat).permit(:body)
  end
end