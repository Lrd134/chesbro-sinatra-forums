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
    
    @post = Post.find(params[:id])
    if !Helpers.logged_in?(session)
      redirect :"/failure/please_login"
    elsif !Helpers.has_session_same?(session_id: session[:user_id], user_id: @post.user_id.to_s)
      redirect :"/failure/you_do_not_own_this_resource"
    else
      @user = User.find(session[:user_id])
      @post = Post.find(params[:id])
      erb :'/posts/edit'
    end
  end
  post '/posts' do
    if params[:post][:title].empty?
      redirect :'/failure/title_must_not_be_empty'
    elsif params[:post][:content].empty?
      redirect :'/failure/post_body_must_have_content'
    else
      @post = Post.create(params[:post])
      redirect :"/posts/#{@post.id}"
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
