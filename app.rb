require 'sinatra/base'
require 'pg'
require_relative 'lib/databaseController'

$db = Database.new

class MakersBnB < Sinatra::Base
  enable :sessions, :method_override

  get '/' do
    erb :sign_up
  end

  get '/signup' do
    erb :sign_up
  end

  get '/signin' do
    erb :sign_in
  end

  post '/signup' do
    $db.sign_up(params[:useremail], params[:password])
    redirect '/signup'
  end

  post '/login' do
    if $db.verifyLogin(params[:useremail], params[:password])
      session.clear
      userData = $db.getUserData(params[:useremail])[0]
      session[:user_id] = userData["userid"]
      session[:user_email] = userData["useremail"]
      redirect '/pass'
    else
      redirect '/fail'
      end
  end

    get '/new' do
      erb :new
    end
    get '/availability' do
        erb :availability, :layout => :layout_user
    end

  post '/logout' do
    session.clear
    redirect '/'
  end

  get '/spaces' do
    erb :space
  end

  get '/fail' do
    erb :fail
  end

  get '/pass' do
    if current_user
      erb :pass
    end
  end

  get '/examplePrivatePage' do
    if current_user
      #CODE ON THE PRIVATE PAGE
      #erb :egPrivPage
    end
  end

  helpers do
    def current_user
      if session[:user_id] != nil
        if $db.DoesUserExist(session[:user_id], session[:user_email])
          p "#{session[:user_email]} : Still logged in!"
        else
          session.clear
          redirect '/fail'
          false
        end
      else
        session.clear
        redirect '/fail'
        false
      end
    end
  end
<<<<<<< HEAD

  get '/booking' do
    erb :booking
  end

  get '/user-portal' do
    erb :user_portal
  end

  post '/user-portal' do
    
=======
>>>>>>> 8aa176a325974703f9a3fd81dceb0ae62de876c6
  run! if app_file == $0
end
