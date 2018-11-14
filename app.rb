require 'sinatra/base'

class MakersBnB < Sinatra::Base
  enable :sessions, :method_override

  get '/' do
    erb :index
  end

  get '/booking' do
    erb :booking
  end

  get '/user-portal' do
    erb :user_portal
  end

  post '/user-portal' do
    
  run! if app_file == $0
end
