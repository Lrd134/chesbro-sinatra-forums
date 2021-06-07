class PostController < ApplicationController

  get '/posts' do
    @posts = Post.all
    erb :'/posts/index'
  end
  get '/posts/new' do
    if Helpers.logged_in?(session)
      @user = User.find(session[:user_id])
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
    if !Helpers.logged_in?(session)
      redirect "/failure/please_login"
    else
      @user = User.find(session[:user_id])
      @post = Post.find(params[:id])
      erb :'/posts/edit'
    end
  end
  post '/posts' do
    @post = Post.create(params[:post])
    redirect "/posts/#{@post.id}"
  end
  patch '/posts/:id' do
    @post = Post.find(params[:id])
    unless !params[:post][:title].empty?
      params[:post][:title] = @post.title
    end
    unless !params[:post][:content].empty?
      params[:post][:content] = @post.content
    end
    @post.update(params[:post])
    redirect "/posts/#{@post.id}"
  end
  delete '/posts/:id' do
    @post = Post.find(params[:id])
    @post.destroy
    redirect '/posts'
  end
end
