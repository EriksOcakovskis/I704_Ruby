module FluffyPaws
  module Repositories
    class LoginToken
      def initialize(db)
        @db = db
      end

      def delete_login_token_by_user_id(user_id)
        token_rows = @db[:login_token].where(user_id: user_id).limit(1).all
        @db[:login_token].where(user_id: user_id).delete unless token_rows.empty?
      end

      def find_login_token_by_token(token)
        token_rows = @db[:login_token].where(token: token).limit(1).all
        if token_rows.empty?
          Models::LoginToken.dummy_token
        else
          Models::LoginToken.new(token_rows[0][:token],
                                 token_rows[0][:expiry_date],
                                 token_rows[0][:user_id],
                                 token_rows[0][:id])
        end
      end

      def delete_login_token_if_old(token)
        token_rows = @db[:login_token].where(token: token).limit(1).all
        return false if token_rows.empty?
        return false if token_rows[0][:expiry_date] >= Time.now
        @db[:login_token].where(token: token).delete
      end

      def delete_login_token_by_token(token)
        @db[:login_token].where(token: token).delete
      end

      def save(login_token)
        delete_login_token_by_user_id login_token.user_id
        @db[:login_token].insert(token: login_token.token,
                                 expiry_date: login_token.expiry_date,
                                 user_id: login_token.user_id)
      end
    end
  end
end
