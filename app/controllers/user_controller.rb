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
      @user = User.find(session[:user_id])
      
      if !@user
        redirect :'/failure/user_not_found'
      end

    else
      redirect :'/failure/please_login'
    end

    unless @user.nil?
      erb :'/users/show'
    end
    

  end
  get '/users/:id/edit' do
    @user = User.find(params[:id])
    if session[:user_id] == @user.id
      erb :'/users/edit'
    else
      erb :'/failure/please_login'
    end
  end
  post '/users' do
    if User.exists?(params[:user][:username])
      redirect :"/failure/user_#{params[:user][:username]}_already_exists"
    else
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
  post '/login' do
    @user = User.authenticate(username: params[:username], password: params[:password])
    if @user
      session[:user_id] = @user.id
      redirect :"/users/#{@user.id}"
    else
      redirect :"/failure/user_not_found"
    end
  end
  patch '/users/:id' do
    user = User.find(session[:user_id])
    
    if params[:user][:username].empty?
      params[:user][:username] = user.username
    end
    if !params[:password].empty?
      
      user.password = params[:password]
    end

    user.update(params[:user])

    redirect :"users/#{user.id}"
  end
end