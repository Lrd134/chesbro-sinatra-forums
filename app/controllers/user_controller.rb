class UserController < ApplicationController

  get '/signup' do
    @users = User.all
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
    if Helpers.has_session_same?(session_id: session[:user_id], user_id: params[:id])
      @logged_in = true
    end
      @user = User.find(params[:id])
      
      erb :'/users/show'
    

  end
  get '/users/:id/edit' do
    @user = User.find(params[:id])
    Helpers.has_session_same?(session_id: session[:user_id], user_id: @user.id) ? erb(:'/users/edit') : erb(:'/failure/please_login')

  end
  post '/users' do
    if Helpers.exists?(params[:user][:username])
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
    @user = Helpers.authenticate(username: params[:username], password: params[:password])
    if @user
      session[:user_id] = @user.id
      redirect :"/users/#{@user.id}"
    elsif !User.find_by_username(params[:username])
      redirect :"/failure/username_not_found"
    elsif params[:password].empty?
      redirect :'/failure/password_can_not_be_empty'
    else
      redirect :'/failure/incorrect_password'
    end
  end
  patch '/users/:id' do
    if Helpers.has_session_same?(session_id: session[:user_id], user_id: params[:id])
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
    if Helpers.has_session_same?(session_id: session[:user_id], user_id: params[:id]) && params[:bool].include?("yes")
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