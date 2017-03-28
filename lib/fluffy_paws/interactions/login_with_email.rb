module FluffyPaws
  module Interactions
    class LogInWithEmail
      def initialize(user_repository, login_token_repository,
                     mailer, clock = Time)
        @clock = clock
        @user_repository = user_repository
        @login_token_repository = login_token_repository
        @mailer = mailer
        @message = nil
      end

      attr_reader :message

      def generate_token
        require 'securerandom'
        SecureRandom.hex(20)
      end

      def run(params)
        user = @user_repository.find_user_by_email(params[:email])
        if user.id
          login_token = Models::LoginToken.new(generate_token,
                                               @clock.now + 5 * 60,
                                               user.id)
          @login_token_repository.save(login_token)
          response = @mailer.send(user: user.user_name, recipient: user.email,
                                  token: login_token.token)
          @message = if response == '202'
                       'e-mail sent!'
                     else
                       'e-mail could NOT be sent!'
                     end
        else
          @message = 'e-mail is not in our system'
        end
      end
    end
  end
end
