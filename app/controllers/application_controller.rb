class ApplicationController < Sinatra::Base
  set :views, proc { File.join(root, '../views/') }
  get '/index' do
    erb :index
  end

end