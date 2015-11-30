class StaticPagesController < ApplicationController

  def home
    @posts = Post.includes([:comments,:topic]).order("created_at desc").limit(10)
    @recent_posts = Post.includes([:comments,:topic]).order("created_at desc").limit(10)
end


  def help
  end

  def about
  end

  def contact
  end
end
