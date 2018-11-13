ENV["RACK_ENV"] ||= "development"


require 'sinatra/base'
#require_relative 'models/space'

class MakersBnB < Sinatra::Base
  enable :sessions
  set :session_secret, 'super secret'
  get '/' do
    'Hello BnB'
  end
  get '/spaces' do
    @spaces = Space.all
    erb :'spaces/availability'
  end

  get '/spaces/new' do
     erb :'spaces/new'
  end

  post '/spaces' do
    redirect '/spaces'
  end
  post '/spaces/filter' do
       Space.create(name: params[:name],
           description: params[:description],
           price: params[:price],
           available_from: params[:available_from],
           available_to: params[:available_to])
       redirect '/spaces'
  end




 run! if app_file == $0
end
