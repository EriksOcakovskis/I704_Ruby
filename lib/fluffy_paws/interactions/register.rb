module FluffyPaws
  module Interactions
    class Register
      def initialize(db)
        @db = db
        @session = nil
        @error = nil
      end

      attr_reader :session
      attr_reader :error

      def run(params)
        user_email_check = @db[:user].where(email: params[:email]).all
        user_name_check = @db[:user].where(user_name: params[:user_name]).all
        if user_email_check
          @error = 'This e-mail already exists, please chose another.'
        elsif user_name_check
          @error = 'This user name already exists, please chose another.'
        else
          user = Models::User.new(params[:user_name],
                                  params[:email],
                                  params[:password])
          @session = user.save @db
        end
      end
    end
  end
end
