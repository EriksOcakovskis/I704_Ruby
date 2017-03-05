module FluffyPaws
  class App < Sinatra::Base
    enable :sessions

    configure do
      set :session_secret, Helpers.load_secret
    end

    get '/' do
      cow = [1, 2, 4]
      title = 'Holy Smokes!'

      context = {
        cow: cow,
        title: title
      }

      unless session[:username].nil?
        username = session[:username]

        context.store(:username, username)
        puts context
      end

      haml :index, locals: context
    end

    post '/login' do
      session[:username] = params[:user]
      redirect to('/')
    end

    get '/logout' do
      session.clear
      redirect to('/')
    end

    post '/json' do
      request.body.rewind
      puts JSON.parse request.body.read
    end
  end
end
