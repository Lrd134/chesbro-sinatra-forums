class UserController < ApplicationController

  get '/signup' do
    @users = User.all
    erb :'/users/new'
  end
  get '/login' do
    erb :'/users/index'
  end

end