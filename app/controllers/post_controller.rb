class PostController < ApplicationController

  get '/posts' do
    @posts = Post.all
    erb :'/posts/index'
  end
  get '/posts/new' do
    @user = current_user
    
    erb :'/posts/new'
  end
  get '/posts/:id' do
    @post = Post.find(params[:id])
    @user = current_user
    erb :'/posts/show'
  end
  get '/posts/:id/delete' do
    @post = Post.find(params[:id])
    erb :'/posts/delete'
  end
  get '/posts/:id/edit' do
    
    @post = Post.find(params[:id])
    
    if !logged_in?
      redirect :"/failure/please_login"
    else
      @user = current_user
      erb :'/posts/edit'
    end
  end
  post '/posts' do
      @post = Post.create(params[:post])
      if @post
        redirect :"/posts/#{@post.id}"
      else
        redirect :'/posts/new'
      end
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
    redirect :"/posts/#{@post.id}"
  end

  delete '/posts/:id' do
    if params[:bool].include?("yes")
      @post = Post.find(params[:id])
      @post.destroy
      redirect :'/posts'
    else 
      redirect :"/posts/#{params[:id]}/edit"
    end
  end
end
