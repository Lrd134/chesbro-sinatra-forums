class Helpers < ApplicationController


  def self.has_session_same_as_login?(session_id:, user_id:)
    session_id == user_id ? true : false
  end
  def self.logout
    session.clear
  end
  def self.authenticate(username:, password:)
    @user = User.find_by_username(username)
    @user && @user.authenticate(password) ? @user : nil
  end
  def self.authenticate_id(user)
    has_session_same_as_login? && (session[:user_id] == user.id) ? true : false
  end
  def self.exists?(username)
    User.find_by_username(username) ? true : false
  end
end
