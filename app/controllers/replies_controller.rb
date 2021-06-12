class RepliesController < ApplicationController

  # GET: /replies

  # GET: /replies/new
  get "/posts/:post_id/reply" do
    @post_id = params[:post_id]
    erb :"/replies/new.html"
  end
  get "/replies/:id/delete" do
    @reply = Reply.find_by(id: params[:id])
    erb :"/replies/delete"
  end
  # POST: /replies
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

  # GET: /replies/5/edit
  get "/replies/:id/edit" do
    @reply = Reply.find_by(id: params[:id])
    erb :"/replies/edit.html"
  end

  # PATCH: /replies/5
  patch "/replies/:id" do
    @reply = Reply.find_by(id: params[:id])
    params[:reply][:user_id] = current_user.id
    params[:reply][:post_id] = @reply.post_id
    @reply.update(params[:reply])
    redirect "/posts/#{@reply.post_id}"
  end

  # DELETE: /replies/5/delete
  delete "/replies/:id/delete" do
    redirect "/replies"
  end
end
