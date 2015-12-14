class CommentMailer < ApplicationMailer

  def comment_submission(user)
    @user = user
    mail to: user.email, subject: "You Received a Comment"
  end
end