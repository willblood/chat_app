class ChatChannel < ApplicationCable::Channel
  def subscribed
    # Use the chat_id sent from the front-end when subscribing
    room_id = params[:room]  # expects front-end to send { room: "room_name" }
    stream_for room_id
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    room_id = data['room']   # use room name sent from front-end
    message = data['message']

    # Broadcast to the room
    ChatChannel.broadcast_to(room_id, {
      user: current_user.username,
      message: message,
      created_at: Time.now
    })
  end
end
