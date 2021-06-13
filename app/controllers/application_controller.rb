class ApplicationController < Sinatra::Base
  configure do
    set :views, "app/views"
    enable :sessions
    set :session_secret, "password_security"
    set :public_folder, 'app/public'
  end
  helpers do
    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end
    def logged_in?
      !!current_user
    end
    def username(user_id)
      User.find_by(id: user_id).username
    end
  end
  get '/' do
    @users = User.all
    erb :'/users/index'
  end

  get '/failure/:failure_params' do
    @failure_reason = params[:failure_params].split("_").map {|r| r.capitalize}.join(" ")
    erb :failure
  end
end