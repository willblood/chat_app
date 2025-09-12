class ChatRepository
  def self.all
    Chat.all
  end

  def self.find(id)
    Chat.find(id)
  end

  def self.find_by(params)
    Chat.find_by(params)
  end

  def self.create(params, current_user, other_user)
    chat = Chat.new(params)
    raise ActiveRecord::RecordInvalid.new(chat), chat.errors unless chat.save
    ChatUserRepository.create({chat_id: chat.id, user_id: current_user.id})
    ChatUserRepository.create({chat_id: chat.id, user_id: other_user.id})
    chat
  end


  def self.update(chat)
    raise ActiveRecord::RecordNotDestroyed.new(chat), chat.errors unless chat.destroy
    true
  end
end
