class Post < ActiveRecord::Base
  belongs_to :user
  has_many :replies
  belongs_to :category
  validates :title, presence: { message: "%{attribute} must be given please." }, uniqueness: {
    # object = person object being validated
    # data = { model: "Person", attribute: "Username", value: <username> }
    message: ->(object, data) do
      "Hey, #{data[:value]} is already in use as a title."
    end
  }
  validates :content, presence: { message: "%{attribute} must be given please." }
end