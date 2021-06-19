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
  get '/delete' do
    @user = current_user
    erb :'users/delete'
  end
  get '/users/:id' do
      @user = User.find(params[:id])
      erb :'/users/show'
  end
  get '/users/:id/edit' do
    @user = current_user
    current_user.id == params[:id].to_i ? erb(:'/users/edit') : redirect(:'/failure/please_login')
  end
  post '/users' do
    @user = User.create(params[:user])
    if @user.errors[:username].empty? && @user.errors[:password].empty?
      session[:user_id] = @user.id
      redirect :"/users/#{@user.id}"
    elsif @user.errors[:username].empty?
      redirect :'/failure/username_cant_be_empty'
    else
      redirect :'/failure/not_you'
    end

  end
  post '/login' do
    @user = User.find_by(params[:user])
    if !!@user
      if @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect :"/users/#{@user.id}"
      else
        redirect :'/failure/invalid_information'
      end
    else
      redirect :'/failure/'
    end
  end
  patch '/users/:id' do
    user = current_user
    
    unless user.id != params[:id].to_i
      
      if params[:user][:username].empty?
        params[:user][:username] = user.username
      end
      user.update(params[:user])
      redirect :"users/#{user.id}"
    end
    
    redirect to :'/failure/'
  end
  delete '/users/delete/:id' do
    unless params[:id].to_i != current_user.id
      if params[:bool].include?("yes")
        user = current_user
        user.destroy
        redirect :'/logout'
      else
        redirect :"/users/#{current_user.id}"
      end
    end
    redirect :'/failure/you_don\'t_own'
  end
end