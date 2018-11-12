require 'sinatra/base'
require 'pg'

class MakersBnB < Sinatra::Base
  enable :sessions, :method_override

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :sign_up
  end

  post '/' do
    username = params['username']
    password = params['password']
    connection = PG.connect(dbname: 'posts')
    connection.exec("INSERT INTO user_details (username, password) VALUES('#{username}', '#{password}')")

    redirect '/'
  end

end
