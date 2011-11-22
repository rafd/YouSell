require 'sinatra'

class App < Sinatra::Base
  set :root, File.dirname(__FILE__)

  $USERS = {}

  get '/' do
    cookie = request.cookies["user"]
    @user = $USERS[cookie] if(cookie and cookie.length > 1)

    erb :index
  end

  post '/login' do
    name = params["name"]
    pass = params["password"]

    if $USERS[name]
      if $USERS[name][:pass] == pass
        response.set_cookie "user", name
      end
    else
      $USERS[name] = {:name=> name, :pass => pass, :balance => 50}

      response.set_cookie "user", name
    end

    redirect '/'
  end


  post '/new' do

  end


  post '/buy' do

  end

  run! if app_file == $0
end