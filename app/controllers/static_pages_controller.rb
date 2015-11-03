class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @posts = Post.includes([:comments,:topic]).order("created_at desc").limit(5)
    else
    @posts = Post.includes([:comments,:topic]).order("created_at desc").limit(5)
    end
end


  def help
  end

  def about
  end

  def contact
  end
end
