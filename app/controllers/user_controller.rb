class UserController < ApplicationController

  get '/signup' do
    @users = User.all
    erb :'/users/new'
  end
  get '/login' do
    erb :'/users/index'
  end
  get '/users/:id' do
    unless User.find(session[:user_id]).nil?
      erb :'users/show'
    end
    redirect :'/failure/user_not_found'
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
end