class CreateChat
  extend LightService::Action

  expects :create_params, :current_user, :other_user
  promises :chat

  executed do |ctx|
    return unless validate_users?(ctx.current_user, ctx.other_user)
    return if existing_chat?(ctx.current_user, ctx.other_user)
    # chat = ChatRepository.create({use})
  rescue
    raise ActiveRecord::RecordInvalid => e
    ctx.fail_and_return!("Failed to create new chat")
  end