require 'sinatra/base'

class MakersBnB < Sinatra::Base
  enable :sessions, :method_override

  get '/' do
    erb :index
  end

  get '/booking' do
    erb: booking
  end

end
