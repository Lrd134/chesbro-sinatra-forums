class User < ActiveRecord::Base
  has_many :posts
  has_secure_password
  def self.authenticate(username:, password:)
    @user = self.find_by_username(username)
    if @user && @user.authenticate(password)
      return @user
    else
      return nil
    end
  end
end