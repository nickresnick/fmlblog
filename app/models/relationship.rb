class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: "User" #it belongs both to the follower and the followed
  belongs_to :followed, class_name: "User"

  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
