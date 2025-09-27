class ChatChannel < ApplicationCable::Channel
  def subscribed
    room_id = Chat.find(params[:chat_id]).name
    stream_for room_id
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    room_id = Chat.find(params[:chat_id]).name
    ActionCable.server.broadcast_to(rom_id,
      user: current_user.username
      {message: data['message']},
    )
  end
end
