class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id]) #for this controller, the id is automatically the activation token
      user.activate
      log_in user
      flash[:success] = "Awesomeness activated bro!"
      redirect_to user
    else
      flash[:danger] = "Invalid activation link, or you're already activated. What are you doing man?"
      redirect_to root_url
    end
  end
end
