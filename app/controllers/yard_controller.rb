class YardController < ApplicationController
  def show
    @chat_messages = ChatMessage.oldest.includes(:user).last(80)
    @chat_message = ChatMessage.new
  end
end
