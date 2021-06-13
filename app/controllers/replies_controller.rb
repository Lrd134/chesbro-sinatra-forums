class RepliesController < ApplicationController

  get "/forums/:slug/:post_id/reply" do
    @post = Post.find_by(id: params[:post_id])
    @cat = Category.find_by_slug(params[:slug])
    if @cat.posts.include?(@post)
      erb :"/replies/new.html"
    end
  end
  get "/forums/:slug/:post_id/replies/:id/delete" do
    @reply = Reply.find_by(id: params[:id])
    if current_user.id == @reply.user_id
      erb :"/replies/delete"
    end
  end
  post "/reply" do
    params[:reply][:user_id] = current_user.id
    reply = Reply.create(params[:reply])
    
    if reply.valid?
      redirect :"/posts/#{reply.post_id}"
    else
      redirect :'/failure'
    end
  end

  # GET: /replies/5
  get "/forums/:slug/:post_id/replies/:id" do
    @reply = Reply.find_by(id: params[:id])
    erb :"/replies/show.html"
  end

  get "/forums/:slug/:post_id/replies/:id/edit" do
    
    @reply = Reply.find_by(id: params[:id])
    if current_user.id == @reply.user_id      
      erb :"/replies/edit.html"
    end
  end

  patch "/replies/:id" do
    @reply = Reply.find_by(id: params[:id])
    params[:reply][:user_id] = current_user.id
    params[:reply][:post_id] = @reply.post_id
    @reply.update(params[:reply])
    redirect "/posts/#{@reply.post_id}"
  end

  delete "/replies/:id/delete" do
    
    @reply = Reply.find_by(id: params[:id])
    if params[:bool] == "yes" && current_user.id == @reply.user_id
      @reply.destroy
    end
    redirect "/posts"
  end
end
