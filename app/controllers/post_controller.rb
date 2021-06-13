class PostController < ApplicationController


  get '/posts/new' do
    @user = current_user
    
    erb :'/posts/new'
  end
  get '/posts/:id' do
    @post = Post.find(params[:id])
    @replies = @post.replies
    erb :'/posts/show'
  end
  get '/posts/:id/delete' do
    @post = Post.find(params[:id])
    if @post.user_id == current_user.id
      erb :'/posts/delete'
    end
  end
  get '/posts/:id/edit' do
    
    @post = Post.find(params[:id])
    
    if logged_in? && current_user.id == @post.user_id
      @user = current_user
      erb :'/posts/edit'
    end
  end
  post '/posts' do
      params[:post][:user_id] = current_user.id
      @post = Post.create(params[:post])
      if @post
        redirect :"/posts/#{@post.id}"
      else
        redirect :'/posts/new'
      end
  end
  patch '/posts/:id' do
    @post = Post.find(params[:id])
    unless current_user.id != @post.user_id
      unless !params[:post][:title].empty?
        params[:post][:title] = @post.title
      end
      unless !params[:post][:content].empty?
        params[:post][:content] = @post.content
      end
      @post.update(params[:post])
      redirect :"/posts/#{@post.id}"
    end
    redirect :"/failure"
  end

  delete '/posts/:id' do
    @post = Post.find(params[:id])
    unless current_user.id != @post.user_id
      if params[:bool].include?("yes")
        @post.destroy
        redirect :'/posts'
      else 
        redirect :"/posts/#{params[:id]}/edit"
      end
    end
    redirect :"/failure"
  end
end
