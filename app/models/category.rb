class Category < ActiveRecord::Base
  has_many :posts

  def slug
    self.name.downcase.split(" ").join("-")
  end
  def deslugify(slug)
    slug.split("-").map { | s | s.capitalize }.join(" ")
  end
  def self.find_by_slug(slug)
    Category.find_by_name(slug.split("-").map { | s | s.capitalize }.join(" "))
  end
end
