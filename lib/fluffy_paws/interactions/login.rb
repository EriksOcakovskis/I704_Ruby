module FluffyPaws
  module Interactions
    class Login
      def initialize(db)
        @db = db
        @session = nil
        @error = nil
      end

      attr_reader :session
      attr_reader :error

      def create_user_from_dataset_result(ds_result)
        if ds_result.empty?
          Models::User.dummy_user
        else
          Models::User.new(ds_result[0][:user_name],
                           ds_result[0][:email],
                           ds_result[0][:password_hash],
                           ds_result[0][:id])
        end
      end

      def find_user_by_username(username)
        user_rows = @db[:user].where(user_name: username).limit(1).all
        create_user_from_dataset_result user_rows
      end

      def run(params)
        user = find_user_by_username params[:username]
        if user.correct_password?(params[:password])
          @session = user.id
        else
          @error = 'Wrong login credentials'
        end
      end
    end
  end
end
