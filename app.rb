require 'sinatra'

class App < Sinatra::Base
  get '/' do
    erb :index
  end

  post '/register' do

  end


  post '/login' do

  end


  post '/new' do

  end


  post '/buy' do

  end

  run! if app_file == $0
end