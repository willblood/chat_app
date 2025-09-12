class ChatUserRepository
  def self.all
    ChatUser.all
  end

  def self.find(id)
    ChatUser.find(id)
  end

  def self.find_by(params)
    ChatUser.find_by(params)
  end

  def self.create(params)
    chat_user = ChatUser.new(params)
    raise ActiveRecord::RecordInvalid.new(chat_user), chat_user.errors unless chat_user.save
    chat_user
  end

  def self.update(chat_user ,params)
    raise ActiveRecord::RecordInvalid.new(chat_user), chat_user.errors unless chat_user.update(params)
    chat_user
  end

  def self.update(chat_user)
    raise ActiveRecord::RecordNotDestroyed.new(chat_user), chat_user.errors unless chat_user.destroy
    true
  end
end
