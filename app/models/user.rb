class User < ActiveRecord::Base
  has_many :posts
  has_many :replies
  has_secure_password
  validates :username, presence: { message: "%{attribute} must be given please." }, uniqueness: {
    # object = person object being validated
    # data = { model: "Person", attribute: "Username", value: <username> }
    message: ->(object, data) do
      "Hey, #{data[:value]} is already taken."
    end
  }
  validates :password, presence: { message: "%{attribute} must be given please" }
end