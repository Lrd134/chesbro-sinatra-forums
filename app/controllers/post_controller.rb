class PostController < ApplicationController

 
  get '/forums/:slug/new' do
    @cat = Category.find_by_slug(params[:slug])
    @user = current_user
    
    erb :'/posts/new'
  end
  get '/forums/:slug/:id' do
    @cat = Category.find_by_slug(params[:slug])
    @post = Post.find(params[:id])
    if @cat.posts.include?(@post) && logged_in?
      @replies = @post.replies
      erb :'/posts/show'
    end
  end
  get '/forums/:slug/:id/delete' do
    @cat = Category.find_by_slug(params[:slug])
    @post = Post.find(params[:id])
    if @post.user_id == current_user.id && @cat.posts.include?(@post)
      erb :'/posts/delete'
    end
  end
  get '/forums/:slug/:id/edit' do
    @cat = Category.find_by_slug(params[:slug])
    @post = Post.find(params[:id])
    
    if current_user.id == @post.user_id && @cat.posts.include?(@post)
      @user = current_user
      erb :'/posts/edit'
    end
  end
  post '/forums/:slug' do
      params[:post][:user_id] = current_user.id
      @post = Post.create(params[:post])
      if @post
        redirect :"/posts/#{@post.id}"
      else
        redirect :'/posts/new'
      end
  end
  patch '/forums/:slug/:id' do
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

  delete '/forums/:slug/:id' do
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
