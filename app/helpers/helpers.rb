class Helpers


  def self.has_session?(user_id)
    session[:user_id] == user_id ? true : false
  end
  def self.logout
    session.clear
  end
  def self.authenticate(username:, password:)
    @user = User.find_by_username(username)
    @user && @user.authenticate(password) ? @user : nil
  end
  def self.authenticate_id(user)
    has_session? && (session[:user_id] == user.id) ? true : false
  end
  def self.exists?(username)
    User.find_by_username(username) ? true : false
  end
end

