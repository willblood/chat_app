class UsersController < ApplicationController
  before_action :authenticate_user, only: [:search]
  def create
    result = CreateUser.execute(create_params: convert_key_to_sym(valid_params.to_h))
    if result.success?
      render json: result.user, status: :ok
    else
      render json: {errors:result.message}, status: :unprocessable_entity
    end
  end

  def search
    return if params[:search].blank?
    search = params[:search]
    result = User.where("username ILIKE ?", "%#{search}%")
    if result.any?
      render json: result, status: :ok
    else
      render json: {error:"no user with such username"}, status: :not_found
    end
  end

  private

  def valid_params
    params.permit(:name, :username, :password, :password_confirmation)
  end
end