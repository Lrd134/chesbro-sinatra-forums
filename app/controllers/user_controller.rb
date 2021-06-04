class UserController < ApplicationController

  get '/signup' do
    @users = User.all
    erb :'/users/new'
  end
  get '/login' do
    erb :'/users/index'
  end
  post '/users' do
    @user = User.create(params[:user])
    session[:user_id] = @user.id
    redirect :"/users/#{@user.id}"

  end
end