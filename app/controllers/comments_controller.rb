class CommentsController < ApplicationController

  def create
    @post = Post.friendly.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    if @comment.save
      @comment.send_comment_submission
      flash.now[:success] = "Comment posted"
      redirect_to @post
    else
      flash.now[:danger] = "error"
    end
  end



  def destroy
    @post = Post.friendly.find(params[:post_id])
    @post.comments.find(params[:id]).destroy
    redirect_to post_path(@post)
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body, :post_id)
  end

end
