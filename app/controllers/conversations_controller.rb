class ConversationsController < ApplicationController
  def index
    @conversations = current_user.conversations.includes(:users, :direct_messages).order(updated_at: :desc)
  end

  def show
    @conversation = Conversation.find(params[:id])
    authorize @conversation
    @messages = @conversation.direct_messages.includes(:user).order(:created_at)
    @direct_message = DirectMessage.new
  end

  def create
    other = User.find_by!(username: params[:username])
    @conversation = Conversation.find_or_create_between(current_user, other)
    authorize @conversation
    redirect_to @conversation
  end
end
