class CommentsController < ApplicationController

  def create
    @post = Post.friendly.find(params[:post_id])
    @post.comments.create(params[:comment].permit(:commenter, :body))
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.friendly.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post)
  end

end
