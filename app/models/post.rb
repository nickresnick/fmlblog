class Post < ActiveRecord::Base

  validates :title, presence: true
  validates :name, presence: true
  validates :content, length: {minimum: 5}

  has_many :comments

end
