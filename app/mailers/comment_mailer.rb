class CommentMailer < ApplicationMailer

  def comment_submission(comment)
    @comment = comment
    mail to: comment.post.user.email, subject: "You Received a Comment"
  end
end