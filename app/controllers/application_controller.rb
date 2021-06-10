class ApplicationController < Sinatra::Base
  configure do
    set :views, "app/views"
    enable :sessions
    set :session_secret, "password_security"
    set :public_folder, 'app/public'
  end
  get '/' do
    erb :index
  end
  get '/failure/:failure_params' do
    @failure_reason = params[:failure_params].split("_").map {|r| r.capitalize}.join(" ")
    erb :failure
  end
  helpers do
    def self.has_session_same?(session_id:, user_id:)
      session_id == user_id.to_i ? true : false
    end
    def self.logged_in?(session)
      !!session[:user_id]
      
    end
        def self.authenticate(username:, password:)
      @user = User.find_by_username(username)
      @user && @user.authenticate(password) ? @user : nil
    end
    def self.exists?(username)
      User.find_by_username(username) ? true : false
    end
  end

  
  
end