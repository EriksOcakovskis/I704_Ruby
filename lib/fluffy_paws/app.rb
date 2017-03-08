module FluffyPaws
  class App < Sinatra::Base
    enable :sessions

    configure do
      set :session_secret, Helpers.load_secret
    end

    DB = Sequel.connect(ENV.fetch('DATABASE_URL'))

    get '/' do
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
      ds = DB[:winuser]
      request.body.rewind
      req_data = JSON.parse request.body.read
      data_kind = req_data['pc_data']['kind']
      pc_name = req_data['pc_data']['data']['Name']

      if data_kind == 'PC info'
        pc_name = 'PC name empty' if pc_name == ''
        ds.insert({pc_name: pc_name, malware_id: 'SPAM'})
      end
    end
  end
end
