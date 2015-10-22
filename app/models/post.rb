class Post < ActiveRecord::Base
  attr_accessor :content, :title, :name

  validates :title, presence: true
  validates :name, presence: true
  validates :content, length: {minimum: 5}
end
