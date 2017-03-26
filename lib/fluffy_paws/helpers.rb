module Sinatra
  module Helpers
    def load_secret
      secret_path = File.expand_path('../../../.secret', __FILE__)

      if File.exist?(secret_path)
        secret = File.read(secret_path)
      else
        require 'securerandom'
        secret = SecureRandom.hex(40)
        File.open(secret_path, 'w') do |file|
          file.write(secret)
        end
      end
      secret
    end

    def authorized?
      session[:user_id]
    end

    def authorize!
      redirect '/login' unless authorized?
    end

    def logout!
      session[:user_id] = nil
    end
  end

  register Helpers
end
