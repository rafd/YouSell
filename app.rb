require 'sinatra'

class App < Sinatra::Base
  set :root, File.dirname(__FILE__)

  $USERS = {"a" => {:name=>"a",:pass=>"a",:balance => 50},"b" => {:name=>"b",:pass=>"b",:balance => 50}}
  $PRODUCTS = [{:name => "Brie Cheese", :description=>"Very Smelly", :price => 10, :owner => "a"},{:name => "Cheddar Cheese", :description=>"Not So Smelly", :price => 5, :owner => "b"}]

  helpers do
    include Rack::Utils
    alias_method :h, :escape_html
  end

  def current_user
    
  end

  get '/' do
    cookie = request.cookies["user"]
    @user= $USERS[cookie] if(cookie and cookie.length > 0)

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


  post '/sell' do
    $PRODUCTS << {
      :name => params["name"], 
      :description => params["description"],
      :price => Integer(params["price"]),
      :owner => params["owner"]
    }

    redirect '/'
  end


  post '/buy' do
    buyer = request.cookies["user"]
    seller = params["owner"]
    price = Integer(params["price"])
    
    $USERS[buyer][:balance] -= price
    $USERS[seller][:balance] += price

    redirect '/'

  end

  run! if app_file == $0
end