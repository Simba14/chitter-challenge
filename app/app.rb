ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative './models/user'

class Chitter < Sinatra::Base
  enable :sessions
  set :session_secret, 'super secret'

  get '/users/new' do
    @user = User.new
    erb :'users/new'
  end

  post '/users' do
    @user = User.create(name: params[:name], email: params[:email],
                        username: params[:username], password: params[:password])
    session[:user_id] = @user.id
    redirect to('/peeps')
  end

  get '/peeps' do
    erb :'peeps/index'
  end

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

end
