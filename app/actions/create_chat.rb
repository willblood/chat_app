class CreateChat
  extend LightService::Action

  expects :current_user, :other_user
  promises :chat

  executed do |ctx|
    return unless validate_users?(ctx.current_user, ctx.other_user, ctx)
    return if existing_chat?(ctx.current_user, ctx.other_user, ctx)
    ctx.chat = ChatRepository.create(
      {name: generate_chat_name(ctx.current_user, ctx.other_user)},
      ctx.current_user,
      ctx.other_user
    )

  rescue ActiveRecord::RecordInvalid => e
    ctx.fail_and_return!("Failed to create new chat")
  end

  private

  def self.validate_users?(current_user, other_user, ctx)
    unless User.exists?(current_user.id) && User.exists?(other_user.id)
      ctx.fail_and_return!("User does not exist")
      return false
    end
    true
  end

  def self.existing_chat?(current_user, other_user, ctx)
    if ChatRepository.find_by(name: generate_chat_name(current_user, other_user))
      ctx.fail_and_return!("Chat already exists between the selected users.")
      return true
    end
    false
  end

  def self.generate_chat_name(current_user, other_user)
    [current_user.id, other_user.id].sort.join("_")
  end
end