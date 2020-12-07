# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  user_name       :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
    # u = User.new({password: "password1234", username: "Miko"})
    attr_reader :password

    validates :user_name, :session_token, uniqueness: true, presence: true
    validates :password_digest, presence: true
    validates :password, length: {minimum: 6, allow_nil: true}

    def reset_session_token!
        self.update!(session_token: SecureRandom::urlsafe_base64)
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        d = BCrypt::Password.new(self.password_digest)
        d.is_password?(password)
    end

    def self.find_by_credentials(user_name, password)
        u = User.find_by(user_name: user_name)
        if u && u.is_password?(password)
            return u
        else
            nil
        end
    end
    
end
