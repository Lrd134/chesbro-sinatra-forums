class Helpers < ApplicationController


  def self.has_session_same?(session_id:, user_id:)
    session_id == user_id.to_i ? true : false
  end
  def self.authenticate(username:, password:)
    @user = User.find_by_username(username)
    @user && @user.authenticate(password) ? @user : nil
  end
  def self.exists?(username)
    User.find_by_username(username) ? true : false
  end
  def self.logged_in?(session)
    !!session[:user_id]
  end
end

