require 'sinatra/base'
require 'pg'
require './lib/bnb'

class MakersBnB < Sinatra::Base
  enable :sessions, :method_override

  get '/' do
    erb :homepage
  end

  get '/signup' do
    erb :sign_up
  end

  post '/signup' do
    Bnb.sign_up(username: params[:username], password: params[:password])
    redirect '/pass'
  end

  post '/login' do
    result = Bnb.sign_in(si_username: params[:si_username], si_password: params[:si_password])
      if result == true
        redirect '/pass'
          elsif result == false
            redirect '/fail'
          end
      end

    get '/spaces/new' do
      erb :new
    end
    get '/spaces/availability' do
        erb :availability
    end

    get '/fail' do
      erb :fail
    end

    get '/pass' do
      erb :pass
    end
    run! if app_file == $0
end
