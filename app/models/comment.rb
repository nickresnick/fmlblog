class Comment < ActiveRecord::Base
  validates :commenter, presence: true
  validates :body, length: {minimum: 5}
  belongs_to :post

  def send_comment_submission
    CommentMailer.comment_submission(self.post.user).deliver_now
  end
end
