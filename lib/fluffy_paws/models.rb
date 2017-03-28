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

      def save(db)
        pw = password_to_hash(@password_hash)
        db[:user].insert(user_name: @user_name,
                         email: @email,
                         password_hash: pw)
      end
    end
  end
end
