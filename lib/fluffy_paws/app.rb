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
      cow = [1, 2, 4]
      title = 'Holy Smokes!'
      all_pcs = DB[:winuser].all

      context = {
        cow: cow,
        title: title,
        all_pcs: all_pcs
      }

      unless session[:username].nil?
        username = session[:username]

        context.store(:username, username)
      end

      haml :index, locals: context
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
      login = Interactions::Login.new(DB)
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
