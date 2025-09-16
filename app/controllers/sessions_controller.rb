class SessionsController < ApplicationController

  def login
    user = UserRepository.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      render json: {token: token}, status: :ok
    else
      render json: { error: 'Invalid credentials'}, status: :unauthorized
    end
  end

end
