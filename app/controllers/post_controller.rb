class PostController < ApplicationController

  get '/posts' do
    @posts = Post.all
    erb :'/posts/index'
  end
  get '/posts/new' do
    if Helpers.logged_in?(session)
      @user = User.find(session(:user_id))
      @show = true
    else
      @show = nil
    end
    
    erb :'/posts/new'
  end
  get '/posts/:id' do
    @post = Post.find(params[:id])
    erb :'/posts/show'
  end

  get '/posts/:id/edit' do
    erb :'/posts/edit'
  end
  post '/posts' do
    binding.pry

  end
end
