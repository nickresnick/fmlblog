class StaticPagesController < ApplicationController

  def home
    @posts = Post.paginate(:page => params[:page], :per_page => 10).order("created_at desc")
    @recent_posts = Post.includes([:comments,:topic]).order("created_at desc").limit(10)

    set_meta_tags :og => {
                      :image    => '/kanye.jpg'
                  }
end


  def help
  end

  def about
  end

  def contact
  end
end
