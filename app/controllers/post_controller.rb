class PostController < ApplicationController

  get '/posts' do
    @posts = Post.all
    erb :'/posts/index'
  end
  get '/posts/new' do
    if ApplicationController.logged_in?(session)
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
    
    @post = Post.find(params[:id])
    if ApplicationController.logged_in?(session)
      redirect :"/failure/please_login"
    elsif !ApplicationController.has_session_same?(session_id: session[:user_id], user_id: @post.user_id.to_s)
      redirect :"/failure/you_do_not_own_this_resource"
    else
      @user = User.find(session[:user_id])
      erb :'/posts/edit'
    end
  end
  post '/posts' do
      @post = Post.create(params[:post])
      binding.pry
      if @post
        redirect :"/posts/#{@post.id}"
      else
        redirect :'/failure'
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
    @post = Post.find(params[:id])
    @post.destroy
    redirect :'/posts'
  end
end
