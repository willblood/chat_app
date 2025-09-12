class UserRepository
  def self.all
    User.all
  end

  def self.find(id)
    User.find(id)
  end

  def self.find_by(params)
    User.find_by(params)
  end

  def self.create(params)
    user = User.new(params)
    raise ActiveRecord::RecordInvalid.new(user), user.errors unless user.save
    user
  end

  def self.update(user ,params)
    raise ActiveRecord::RecordInvalid.new(user), user.errors unless user.update(params)
    user
  end

  def self.update(user)
    raise ActiveRecord::RecordNotDestroyed.new(user), user.errors unless user.destroy
    true
  end
end
