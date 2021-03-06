require 'sinatra/base'
require 'pg'
require_relative 'lib/databaseController'

$db = Database.new

class MakersBnB < Sinatra::Base
  enable :sessions, :method_override

  get '/' do
    erb :index, :layout => :layout
  end

  get '/signup' do
    erb :sign_up
  end

  get '/signin' do
    erb :sign_in
  end

  post '/signup' do
    $db.sign_up(params[:useremail], params[:password])
    redirect '/signin'
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
    if current_user
      erb :new, :layout => :layout_user
    end
  end

  post '/new' do
    address = "#{params[:adr1]},#{params[:adr2]},#{params[:adr3]},#{params[:postcode]}"
    if $db.createLocation(session[:user_id], params[:name], params[:desc], params[:ppn], address)
      redirect '/user_portal'
    else
      erb :fail_new
    end
  end

  get '/availability' do
    if (session[:startdate] == nil || session[:startdate] == "")
      puts "aaaa"
      session[:startdate] = "2000-1-1"
      session[:enddate] = "2024-1-1"
    end
    @rooms = $db.getAllRooms(session[:startdate], session[:enddate])
    if current_user_no_redirect
      erb :availability, :layout => :layout_user
    else
      erb :availability
    end
  end

  post "/booking" do
    @locationid = params["locationid"]
    if $db.makeBooking(session[:user_id], @locationid, session[:startdate], session[:enddate])
      erb :booking, :layout => :layout_user
    else
      erb :fail_failedbooking, :layout => :layout_user
    end
  end

  post '/availability' do
    session[:startdate] = params[:start]
    session[:enddate] = params[:end]
    redirect '/availability'
  end

  post '/logout' do
    session.clear
    redirect '/'
  end

  get '/fail' do
    erb :fail
  end

  get '/pass' do
    if current_user
      erb :pass, :layout => :layout_user
    end
  end

  get '/payments' do
    erb :payments, :layout => :layout_user
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
    def current_user_no_redirect
      if session[:user_id] != nil
        if $db.DoesUserExist(session[:user_id], session[:user_email])
          p "#{session[:user_email]} : Still logged in!"
        else
          false
        end
      else
        false
      end
    end
  end

  get '/user_portal' do
    if current_user
      @currentbookings = $db.getUsersBookings(session[:user_id])
      @userslistings = $db.getUsersLocations(session[:user_id])
      erb :user_portal, :layout => :layout_user
    end
  end

  post '/user_portal' do
    erb :user_portal, :layout => :layout_user
  end

  run! if app_file == $0
end
