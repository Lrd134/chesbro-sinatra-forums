class ApplicationController < Sinatra::Base
  configure do
    set :views, "app/views"
    enable :sessions
    set :session_secret, "password_security"
    set :public_folder, 'app/public'
  end
  helpers do

    def self.authenticate(username:, password:)
      @user = User.find_by_username(username)
      @user && @user.authenticate(password) ? @user : nil
    end
    def current_user
      binding.pry
      @current_user ||= User.find(session[:user_id])
    end
    def logged_in?
      !!current_user
      
    end
  end
  get '/' do
    erb :index
  end
  get '/failure/:failure_params' do
    @failure_reason = params[:failure_params].split("_").map {|r| r.capitalize}.join(" ")
    erb :failure
  end


  
  
end