require 'sinatra/base'
require 'pg'
require './lib/bnb'

class MakersBnB < Sinatra::Base
  enable :sessions, :method_override

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :sign_up
  end

  post '/signup' do
    Bnb.sign_up(username: params[:username], password: params[:password])
    redirect '/'
  end

  post '/login' do
    result = Bnb.sign_in(si_username: params[:si_username], si_password: params[:si_password])
      if result == true
        redirect '/'
          elsif result == false
            redirect '/fail'
          end
      end

    get '/fail' do
      erb :fail
    end
end
