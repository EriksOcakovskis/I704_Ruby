# # Module FluffyPaws
# # module FluffyPaws
#   # App class inherits from Sinatra
#   # class App < Sinatra::Base
#     set :views, settings.root + '/fluffy_paws/views'
#     get '/' do
#       haml :index
#     end
#   # end
# # end

# Sesion secret only for dev version
set :session_secret, 't38u3v58gn458gH^%RBBEZvtwy4348rqp203r9ucgno5hm4vhgJTYn3gv'
set :views, settings.root + '/fluffy_paws/views'
set :public_folder, settings.root + '/fluffy_paws/public'

enable :sessions

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
