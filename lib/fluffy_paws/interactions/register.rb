module FluffyPaws
  module Interactions
    class Register
      def initialize(user_repository)
        @user_repository = user_repository
        @session = nil
        @error = nil
      end

      attr_reader :session
      attr_reader :error

      def duplicate_check(params)
        user_email_check = @user_repository.find_user_by_email(params[:email])
        user_name_check = @user_repository.find_user_by_username(
          params[:user_name]
        )
        if user_email_check.id
          @error = 'This e-mail already exists, please chose another.'
        elsif user_name_check.id
          @error = 'This user name already exists, please chose another.'
        end
      end

      def run(params)
        duplicate_check params
        return false if @error
        user = Models::User.new(params[:user_name],
                                params[:email],
                                params[:password])
        @session = @user_repository.save(user)
      end
    end
  end
end
