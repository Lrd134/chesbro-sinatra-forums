class ApplicationController < Sinatra::Base
  set :views, proc { File.join(root, '../views/') }
  
  get '/' do
    erb :index
  end

end