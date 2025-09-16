class ApplicationController < ActionController::API
  attr_reader :current_user

  def authenticate_user
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = UserRepository.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message}, status: :unauthorized
    end
  end


  def convert_key_to_sym(params)
    params.each_with_object({}) do |(key, value), result|
      result[key.to_sym] = value
    end
  end
end
