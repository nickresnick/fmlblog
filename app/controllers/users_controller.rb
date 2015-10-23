class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy,
                                        :following, :followers] #specificying edit and update means that the before requirement only pertains to those methods
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def index #remember that when this, and edit and new are called upon by a route, it automatically goes to the view with the same name as well
    @users = User.paginate(page: params[:page])
  end

  def new
    if logged_in?
      redirect_to @current_user
      flash[:info] = "You're already signed up bro!"
    else
      if @user.admin?
        @user = User.new
      else
        redirect_to root
      end
      end
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url #Now we don't send them to their profile, instead we send them back to root for them to check email
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user) #This implies current_user takes the value of a user object
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def admin_user #Defines admin user for before action
    if current_user && !current_user.admin?
      redirect_to root_url
    elsif !current_user
      redirect_to login_path
    end
    end

  def not_logged_in
    logged_in?
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page]) #So the .paginate in many other spots in this code takes the following objects and paginates them
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def make_admin
    @user = User.find(params[:id])
    if @user.admin? == false
      @user.admin = true
    end
    redirect_to @user
  end

  private #AAAAAAAAAAAAANNNNNNYYYTTTTHHHHHHHHIIIINNNNGGGGG Below here is PRIVATE

    def user_params
    params.require(:user).permit(:name, :email, :password, #Note here that remember_digest and admin are left out so ppl can't edit them
                                 :password_confirmation)
    end

    def micropost_params
      params.require(:micropost).permit(:content, :picture)
    end

end