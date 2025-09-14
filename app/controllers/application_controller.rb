class ApplicationController < ActionController::Base
  helper_method :current_user
  def current_user
    current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_logged_in?
    unless current_user.present?
      render json: { error: "Unauthorized" }, status: :unauthorized
      return
    end
  end


  def convert_key_to_sym(params)
    params.each_with_object({}) do |(key, value), result|
      result[key.to_sym] = value
    end
  end
end
