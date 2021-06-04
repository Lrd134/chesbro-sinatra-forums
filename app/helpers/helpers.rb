class Helpers

  def self.curr_user
    User.find(session[:user_id])
  end
  def has_session?
    session[:user_id] ? true : false
  end
  def self.authenticate(username:, password:)
    @user = User.find_by_username(username)
    if @user && @user.authenticate(password)
      return @user
    else
      return nil
    end
  end
  def self.exists?(username)
    if User.find_by_username(username)
      return true
    else 
      return false
    end
  end
end

