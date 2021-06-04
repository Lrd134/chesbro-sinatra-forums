class ApplicationController < Sinatra::Base
  configure do
    set :views, "app/views"
    enable :sessions
    set :session_secret, "password_security"
  end
  get '/' do
    erb :index
  end
  get '/failure/:failure_params' do
    @failure_reason = params[:failure_params].split("_").map {|r| r.capitalize}.join(" ")
    erb :failure
  end
  get '/logout' do

  end
end