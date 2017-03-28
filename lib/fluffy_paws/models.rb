module FluffyPaws
  module Models
    class User
      def initialize(user_name, email, password_hash, id = nil)
        @id = id
        @user_name = user_name
        @email = email
        @password_hash = password_hash
      end

      attr_reader :id
      attr_reader :user_name
      attr_reader :email
      attr_reader :password_hash

      def self.dummy_user
        new(nil, nil, nil, nil)
      end

      def password_to_hash(password)
        BCrypt::Password.create(password)
      end

      def correct_password?(password)
        pw = if @password_hash
               BCrypt::Password.new(@password_hash)
             else
               false
             end
        pw == password
      end
    end

    class LoginToken
      def initialize(token, expiry_date, user_id, id = nil)
        @id = id
        @token = token
        @expiry_date = expiry_date
        @user_id = user_id
      end

      def self.dummy_token
        new(nil, nil, nil, nil)
      end

      attr_reader :id
      attr_reader :token
      attr_reader :expiry_date
      attr_reader :user_id
    end
  end
end
