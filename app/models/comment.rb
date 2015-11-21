class Comment < ActiveRecord::Base
  validates :commenter, presence: true
  validates :body, length: {minimum: 5}
  belongs_to :post
end
