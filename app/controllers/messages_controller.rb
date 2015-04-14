class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
  	@users = User.all
  end

  def new
    @message = Message.new
    @recv_uid = params[:recv_uid]
  end

  def show
    @message = Message.where(:receiver_user_id => current_user.id)
  end

  def sent
    @sentmessage = Message.where(:user_id => current_user.id)
  end

  def create
    @message = Message.new(message_params)
    @message.user = current_user

    respond_to do |format|
      if @message.save
        format.html { redirect_to root_url, notice: 'Message was sent successfully.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end
 
  private

  def message_params
    params.require(:message).permit(:message, :user_id, :receiver_user_id)
  end

end
