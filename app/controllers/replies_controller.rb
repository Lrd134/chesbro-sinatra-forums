class RepliesController < ApplicationController

  get "/posts/:post_id/reply" do
    @post_id = params[:post_id]
    erb :"/replies/new.html"
  end
  get "/replies/:id/delete" do
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
  get "/replies/:id" do
    @reply = Reply.find_by(id: params[:id])
    erb :"/replies/show.html"
  end

  get "/replies/:id/edit" do
    
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
