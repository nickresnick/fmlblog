class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
      @posts = Post.includes(:comments).order("created_at desc").limit(5)
    else
    @posts = Post.includes(:comments).order("created_at desc").limit(5)
    end
end


  def help
  end

  def about
  end

  def contact
  end
end
