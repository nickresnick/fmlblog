class CommentsController < ApplicationController

  def create
    @post = Post.friendly.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    if @comment.save
      @comment.send_comment_submission
      flash[:success] = "Comment posted"
      redirect_to @post
    else
      flash[:danger] = "error"
    end
  end



  def destroy
    @post = Post.friendly.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    flash[:success] = "Comment deleted"
    redirect_to @post
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body, :post_id)
  end

end
