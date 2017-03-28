module FluffyPaws
  module Interactions
    class Login
      def initialize(user_repository)
        @user_repository = user_repository
        @session = nil
        @error = nil
      end

      attr_reader :session
      attr_reader :error

      def run(params)
        user = @user_repository.find_user_by_username params[:username]
        if user.correct_password?(params[:password])
          @session = user.id
        else
          @error = 'Wrong login credentials'
        end
      end
    end
  end
end
