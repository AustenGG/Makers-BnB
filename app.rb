require 'sinatra/base'
require 'pg'
require_relative 'lib/bnb'

$db = Bnb.new

class MakersBnB < Sinatra::Base
  enable :sessions, :method_override

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :sign_up
  end

  post '/signup' do
    $db.sign_up(username: params[:username], password: params[:password])
    redirect '/pass'
  end

  post '/login' do
    result = $db.sign_in(si_username: params[:si_username], si_password: params[:si_password])
      if result == true
        redirect '/pass'
          elsif result == false
            redirect '/fail'
          end
      end

    get '/fail' do
      erb :fail
    end

    get '/pass' do
      erb :pass
    end
end
