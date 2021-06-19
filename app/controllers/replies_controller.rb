class RepliesController < ApplicationController

  get "/forums/:slug/:post_id/reply" do
    @post = Post.find_by(id: params[:post_id])
    @cat = Category.find_by_slug(params[:slug])
    if @cat.posts.include?(@post)
      erb :"/replies/new.html"
    end
  end
  get "/forums/:slug/:post_id/replies/:id/delete" do
    @cat = Category.find_by_slug(params[:slug])
    @post = Post.find_by(id: params[:post_id])
    @reply = Reply.find_by(id: params[:id])
    if current_user.id == @reply.user_id && @cat.posts.include?(@post)
      erb :"/replies/delete"
    end
  end
  post "/forums/:slug/:post_id/reply" do
    @cat = Category.find_by_slug(params[:slug])
    @post = Post.find_by(id: params[:post_id])
    params[:reply][:post_id] = @post.id
    params[:reply][:user_id] = current_user.id
    unless !@cat.posts.include?(@post)
      reply = Reply.create(params[:reply])
    end
    if reply.valid?
      redirect :"/forums/#{@cat.slug}/#{reply.post_id}"
    else
      redirect :'/failure/unknown'
    end
  end

  # GET: /replies/5
  get "/forums/:slug/:post_id/replies/:id" do
    @cat = Category.find_by_slug(params[:slug])
    @post = Post.find_by(id: params[:post_id])
    @reply = Reply.find_by(id: params[:id])
    erb :"/replies/show.html"
  end

  get "/forums/:slug/:post_id/replies/:id/edit" do
    @cat = Category.find_by_slug(params[:slug])
    @post = Post.find_by(id: params[:post_id])
    @reply = Reply.find_by(id: params[:id])
    if current_user.id == @reply.user_id      
      erb :"/replies/edit.html"
    end
  end

  patch "/forums/:slug/:post_id/replies/:id" do
    @cat = Category.find_by_slug(params[:slug])
    @post = Post.find_by(id: params[:post_id])
    @reply = Reply.find_by(id: params[:id])
    params[:reply][:user_id] = current_user.id
    params[:reply][:post_id] = @reply.post_id
    valid = @cat.posts.include?(@post)
    if valid
      @reply.update(params[:reply])
      redirect :"/forums/#{@cat.slug}/#{@reply.post_id}"
    else
      redirect :"/failure/unknown"
    end
  end

  delete "/forums/:slug/:post_id/replies/:id/delete" do
    @cat = Category.find_by_slug(params[:slug])
    @post = Post.find_by(id: params[:post_id])
    @reply = Reply.find_by(id: params[:id])
    if params[:bool] == "yes" && current_user.id == @reply.user_id && @cat.posts.include?(@post)
      @reply.destroy
      redirect :"/forums"
    else
      redirect :"/forums/#{@cat.slug}/#{@post.id}/replies/#{@reply.id}/edit"
    end
    
  end
end
