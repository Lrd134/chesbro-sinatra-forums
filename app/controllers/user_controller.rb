class UserController < ApplicationController

  get '/signup' do
    @users = User.all
    erb :'/users/new'
  end
  get '/login' do
    erb :'/users/index'
  end
  get '/logout' do
    session.clear
    redirect :'/'
  end
  get '/users/:id' do
    if session[:user_id]

      unless User.find(session[:user_id]).nil?
        erb :'users/show'
      end
      redirect :'/failure/user_not_found'
    else
      redirect :'/failure/please_login'
    end
  end
  post '/users' do
    unless params[:user][:username].empty?
      unless params[:user][:password].empty?
        @user = User.create(params[:user])
        if @user
          session[:user_id] = @user.id
          redirect :"/users/#{@user.id}"
        else
          failure = "server_error"
          redirect :"/failure/#{failure}"
        end
      end
      failure = "invalid_password_given"
      redirect :"/failure/#{failure}"
    end
    failure = "invalid_username_given"
    redirect :"/failure/#{failure}"
  end
  post '/login' do
    @user = User.authenticate(username: params[:username], password: params[:password])
    binding.pry

  end
end