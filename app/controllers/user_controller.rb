class UserController < ApplicationController

  get '/signup' do
    erb :'/users/new'
  end
  get '/login' do
    erb :'/users/login'
  end
  get '/logout' do
    session.clear
    redirect :'/'
  end
  get '/users' do
    @users = User.all
    erb :'/users/index'
  end
  get '/delete' do
    @user = User.find(params[:user][:id])
    erb :'users/delete'
  end
  get '/users/:id' do
    if ApplicationController.has_session_same?(session_id: session[:user_id], user_id: params[:id])
      @logged_in = true
    end
      @user = User.find(params[:id])
      
      erb :'/users/show'
    

  end
  get '/users/:id/edit' do
    @user = User.find(params[:id])
    !ApplicationController.has_session_same?(session_id: session[:user_id], user_id: @user.id) ? redirect(:'/failure/please_login') : erb(:'/users/edit')

  end
  post '/users' do
    @user = User.create(params[:user])
    if @user.errors[:username].empty? && @user.errors[:password].empty?
      session[:user_id] = @user.id
      redirect :"/users/#{@user.id}"
    elsif @user.errors[:username].empty?
      redirect :'/failure'
    else
      redirect :'/failure'
    end

  end
  post '/login' do
    @user = ApplicationController.authenticate(username: params[:username], password: params[:password])
    if @user
      session[:user_id] = @user.id
      redirect :"/users/#{@user.id}"
    else
      redirect :'/failure/incorrect_password'
    end
  end
  patch '/users/:id' do
    if ApplicationController.has_session_same?(session_id: session[:user_id], user_id: params[:id])
      user = User.find(params[:id])
    end
    
    if params[:user][:username].empty?
      params[:user][:username] = user.username
    end
    if !params[:password].empty?
      
      user.password = params[:password]
    end

    user.update(params[:user])
    redirect :"users/#{user.id}"
  end
  delete '/users/delete/:id' do
    if ApplicationController.has_session_same?(session_id: session[:user_id], user_id: params[:id]) && params[:bool].include?("yes")
      user = User.find(params[:id])
      user.destroy
      redirect :'/logout'
    elsif params[:bool] == "no"
      redirect :'/failure/you_choose_the_non_violent_path_today'
    else
      redirect :'/failure/server_error'
    end
  end
end