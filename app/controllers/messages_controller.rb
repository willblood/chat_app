class MessagesController < ApplicationController
  before_action :authenticate_user

  def create
    result = CreateMessage.execute(
      current_user: current_user, 
      params: convert_key_to_sym(valid_params.to_h)
    )
    if result.success?
      room_id = ChatRepository.find(params[:chat_id]).name
      message = result.message_data
      # Broadcast to the room
      ChatChannel.broadcast_to(room_id, {
        user: current_user.username,
        user_id:message[:user_id],
        content: message[:content],
        chat_id: message[:chat_id],
        created_at: message[:created_at]
      })
      render json: result.message_data, status: :ok
    elsif result.message == "Chat does not exist"
      render json: {error: result.message}, status: :not_found
    else
      render json: {error: result.message}, status: :unprocessable_entity
    end
  end

  private
  def valid_params
    params.permit(:chat_id, :content).merge(user_id: current_user.id)
  end
end