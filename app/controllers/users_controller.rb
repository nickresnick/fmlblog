class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index] #specificying edit and update means that the before requirement only pertains to those methods
  before_action :correct_user,   only: [:edit, :update]
  def show
    @user = User.find(params[:id])
  end

  def index #remember that when this, and edit and new are called upon by a route, it automatically goes to the view with the same name as well
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find_by(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
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

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in? #if logged_in? returns false, they proceed with the flash
      store_location #Store their attempted URL
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user) #This implies current_user takes the value of a user object
  end

  private #AAAAAAAAAAAAANNNNNNYYYTTTTHHHHHHHHIIIINNNNGGGGG Below here is PRIVATE

    def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
    end


end