class RepliesController < ApplicationController

  # GET: /replies

  # GET: /replies/new
  get "/posts/:post_id/reply" do
    @post_id = params[:post_id]
    erb :"/replies/new.html"
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
    erb :"/replies/edit.html"
  end

  # PATCH: /replies/5
  patch "/replies/:id" do
    redirect "/replies/:id"
  end

  # DELETE: /replies/5/delete
  delete "/replies/:id/delete" do
    redirect "/replies"
  end
end
