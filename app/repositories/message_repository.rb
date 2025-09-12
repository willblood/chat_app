class MessageRepository
  def self.all
    Message.all
  end

  def self.find(id)
    Message.find(id)
  end

  def self.find_by(params)
    Message.find_by(params)
  end

  def self.create(params)
    message = Message.new(params)
    raise ActiveRecord::RecordInvalid.new(message), message.errors unless message.save
    message
  end

  def self.update(message ,params)
    raise ActiveRecord::RecordInvalid.new(message), message.errors unless message.update(params)
    message
  end

  def self.update(message)
    raise ActiveRecord::RecordNotDestroyed.new(message), message.errors unless message.destroy
    true
  end
end
