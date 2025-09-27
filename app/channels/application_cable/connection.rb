module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def Connection
      self.current_user = find_verified_user
    end

    private
    def find_verified_user
      token = request.params[:token]
      payload = decode_jwt(token)

      if (user = User.find_by(id: payload["user_id"]))
        user
      else
        reject_unauthorized_connection
      end
    rescue
      reject_unauthorized_connection
    end

    def decode_jwt(token)
      JWT.decode(token, Rails.application.secret_key_base, true, algorithm: "HS256")[0]
    end
  end
end
