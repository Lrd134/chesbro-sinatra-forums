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
    current_user.id == params[:id] ? redirect(:'/failure/please_login') : erb(:'/users/edit')
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
    
    unless current_user.id != params[:id]
      if params[:user][:username].empty?
        params[:user][:username] = user.username
      end
      user.update(params[:user])
      redirect :"users/#{user.id}"
    end
    redirect to :'/failure/'
  end
  delete '/users/delete/:id' do
    unless params[:id] != current_user.id
      if params[:bool].include?("yes")
        user = current_user
        user.destroy
        redirect :'/logout'
      else
        redirect :'/failure/you_choose_the_non_violent_path_today'
      end
    end
    redirect :'/failure/you_don\'t_own'
  end
end