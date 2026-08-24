class ChatMessagesController < ApplicationController
  def create
    @chat_message = current_user.chat_messages.build(chat_message_params)
    authorize @chat_message

    if @chat_message.save
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("yard-form", partial: "chat_messages/form", locals: { chat_message: ChatMessage.new }) }
        format.html { redirect_to yard_path }
      end
    else
      redirect_to yard_path, alert: @chat_message.errors.full_messages.to_sentence
    end
  end

  private

  def chat_message_params
    params.require(:chat_message).permit(:body)
  end
end
