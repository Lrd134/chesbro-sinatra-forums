class PostController < ApplicationController

  get '/posts' do
    @posts = Post.all
    erb :'/posts/index'
  end
  get '/posts/:id' do
    @post = Post.find(params[:id])
    erb :'/posts/show'
  end
  get '/posts/new' do
    erb :'/posts/new'
  end
  get '/posts/:id/edit' do
    erb :'/posts/edit'
  end
end
