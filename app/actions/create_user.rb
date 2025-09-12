class CreateUser
  extend LightService::Action
  expects  :create_params
  promises :user

  executed do |ctx|
    return unless validate_params?(ctx.create_params, ctx)
    return unless validate_username?(ctx.create_params, ctx)
    ctx.user = UserRepository.create(ctx.create_params)
  rescue ActiveRecord::RecordInvalid => e
    ctx.fail_and_return!("Failed to create user")
  end

  private
  def self.validate_params?(create_params, ctx )
    unless create_params.is_a?(Hash)
      ctx.fail_and_return!("Params must be a hash")
      return false
    end
    %i[name username password  password_confirmation].each do |key|
      unless create_params.has_key?(key)
        ctx.fail_and_return!("#{key} key is missing")
        return false
      end

      if create_params[key].blank?
        ctx.fail_and_return!("#{key} field is blank")
        return false
      end
    end
    true
  end

  def self.validate_username?(create_params, ctx)
    if User.exists?(username: create_params[:username])
      ctx.fail_and_return!("Username already exists")
      return false
    end
    true
  end

end