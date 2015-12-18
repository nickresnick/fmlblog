class CommentsController < ApplicationController

  def create
    @post = Post.friendly.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    if @comment.save
      @comment.send_comment_submission
      format.html {redirect_to @post, notice: 'Comment was successfully posted.' }
    else
      flash.now[:danger] = "error"
    end
  end



  def destroy
    @post = Post.friendly.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post)
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body, :post_id)
  end

end
