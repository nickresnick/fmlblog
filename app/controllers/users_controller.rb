class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to heaven Bro!" #flash method is used to make a temporary message on a page
      redirect_to user_url(@user)
    else
      render 'new'
    end

  end

  private

    def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation) #so that anytime we use user_params,
    # we know the only information being shared are those four fields, and any other sensitive info is under our control
    end
end
