class CategoriesController < ApplicationController

  # GET: /categories
  get "/forums" do
    @cats = Category.all
    erb :"/categories/index"
  end

  # GET: /categories/new
  get "/categories/new" do
    erb :"/categories/new"
  end

  # POST: /categories
  post "/categories" do
    redirect "/categories"
  end

  # GET: /categories/5
  get "/forums/:slug" do
    if logged_in?
      @cat = Category.find_by_slug(params[:slug])
      erb :"/categories/show"
    else
      redirect to :'/failure/please_login'
    end
  end
  # GET: /categories/5/edit
  get "/categories/:id/edit" do
    erb :"/categories/edit"
  end

  # PATCH: /categories/5
  patch "/categories/:id" do
    redirect "/categories/:id"
  end

  # DELETE: /categories/5/delete
  delete "/categories/:id/delete" do
    redirect "/categories"
  end
end
