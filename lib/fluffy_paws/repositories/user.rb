module FluffyPaws
  module Repositories
    class User
      def initialize(db)
        @db = db
      end

      def find_user_by_username(user_name)
        user_rows = @db[:user].where(user_name: user_name).limit(1).all
        if user_rows.empty?
          Models::User.dummy_user
        else
          Models::User.new(user_rows[0][:user_name],
                           user_rows[0][:email],
                           user_rows[0][:password_hash],
                           user_rows[0][:id])
        end
      end

      def find_user_by_email(email)
        user_rows = @db[:user].where(email: email).limit(1).all
        if user_rows.empty?
          Models::User.dummy_user
        else
          Models::User.new(user_rows[0][:user_name],
                           user_rows[0][:email],
                           user_rows[0][:password_hash],
                           user_rows[0][:id])
        end
      end

      def save(user)
        pw = user.password_to_hash(user.password_hash)
        @db[:user].insert(user_name: user.user_name,
                          email: user.email,
                          password_hash: pw)
      end
    end
  end
end
