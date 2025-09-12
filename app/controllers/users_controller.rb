class UsersController < ApplicationController
  def create
    result = CreateUser(create_params: convert_key_to_sym(valid_params.to_h))
    if result.success?
      render json: result.user, status: :ok
    else
      render json: {errors:result.message}, status: :unprocessable_entity
    end
  end

  private

  def valid_params
    params.require(:user).permit(:name, :username, :password, :password_confirmation)
  end

  def convert_key_to_sym(params)
    params.each_with_object({}) do |(key, value), result|
      result[key.to_sym] = value
    end
  end
end