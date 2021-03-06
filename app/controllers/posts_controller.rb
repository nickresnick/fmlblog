class PostsController < ApplicationController
  include ActionView::Helpers::TextHelper

  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:create, :destroy, :edit]
  after_filter "save_my_previous_url", only: [:new]



  # GET /posts
  # GET /posts.json

  def index
    @posts = Post.search(params[:search]).paginate(:page => params[:page], :per_page => 10)
  end


  # GET /posts/1
  # GET /posts/1.json
  def show
    impressionist(@post)
    @recent_posts = Post.includes([:comments,:topic]).order("created_at desc").limit(10)

    set_meta_tags :og => {
                      :title    => @post.title,
                      :image    => @post.picture
                  }

    set_meta_tags :twitter => {
                      :card    => "summary",
                      :title    => @post.title,
                      :image    => @post.picture,
                      :description => @post.caption
                  }

    set_meta_tags :image => @post.picture,
        :description => @post.caption
  end

  def save_my_previous_url
    # session[:previous_url] is a Rails built-in variable to save last url.
    session[:my_previous_url] = URI(request.referer || '').path
    @back_url = session[:my_previous_url]
  end

  # GET /posts/new
  def new
    if logged_in?
      @post = Post.new
    else
      redirect_to root_path
      flash[:info] = "You're not authorized to make a post"
    end
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    if current_user.admin?
      @post = current_user.posts.build(post_params)
    else
      format.html { redirect_to root, notice: 'You are not authorized to make posts' }
    end

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    @post = Post.friendly.find(params[:id])

    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.friendly.find(params[:id])
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:name, :title, :content, :picture, :user_id, :topic_id, :caption)
    end


end
