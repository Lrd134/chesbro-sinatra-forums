class CatergoriesController < ApplicationController

  # GET: /catergories
  get "/catergories" do
    erb :"/catergories/index.html"
  end

  # GET: /catergories/new
  get "/catergories/new" do
    erb :"/catergories/new.html"
  end

  # POST: /catergories
  post "/catergories" do
    redirect "/catergories"
  end

  # GET: /catergories/5
  get "/catergories/:id" do
    erb :"/catergories/show.html"
  end

  # GET: /catergories/5/edit
  get "/catergories/:id/edit" do
    erb :"/catergories/edit.html"
  end

  # PATCH: /catergories/5
  patch "/catergories/:id" do
    redirect "/catergories/:id"
  end

  # DELETE: /catergories/5/delete
  delete "/catergories/:id/delete" do
    redirect "/catergories"
  end
end
