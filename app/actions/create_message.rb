class CreateMessage
  extend LightService::Action

  expects  :params
  promises :message_data

  executed do |ctx|
    return unless valid_params?(ctx.params, ctx)
    return unless valid_chat?(ctx.params, ctx)

    ctx.message_data = MessageRepository.create(ctx.params)
  rescue  ActiveRecord::RecordInvalid => e 
    ctx.fail_and_return!("Failed to create message: #{e.message}")
  end

  private

  def self.valid_params?(params, ctx)
    unless params.is_a?(Hash)
      ctx.fail_and_return!("params must be a hash")
      return false
    end

    %i[chat_id user_id content].each do |key|
      unless params.has_key?(key)
        ctx.fail_and_return!("Missing required param #{key}")
        return false
      end

      if params[key].blank?
        ctx.fail_and_return!("#{key} field is blank")
        return false
      end
    end
    true
  end

  def self.valid_chat?(params, ctx)
    unless Chat.exists?(id: params[:chat_id])
      ctx.fail_and_return!("Chat does not exist")
      return false
    end
    true
  end
end
