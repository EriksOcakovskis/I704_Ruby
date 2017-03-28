module FluffyPaws
  module Interactions
    class AuthorizeToken
      def initialize(login_token_repository)
        @login_token_repository = login_token_repository
        @session = nil
        @error = nil
      end

      attr_reader :session
      attr_reader :error

      def run(params)
        @login_token_repository.delete_login_token_if_old params[:token]
        token = @login_token_repository.find_login_token_by_token params[:token]
        if token.id
          @session = token.user_id
          @login_token_repository.delete_login_token_by_token params[:token]
        else
          @error = 'Token invalid'
        end
      end
    end
  end
end
