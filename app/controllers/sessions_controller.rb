class SessionsController < ApplicationController
  def new
  end

  def create
    #render 'new'
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      #Log the user in and redirect to his page
      log_in user
      #If remember_me is checked call remember function, otherwise call forget
      params[:session][:remember_me] == 1 ? remember(user) : forget(user)
      remember user
      redirect_to user
    else
      #Create an error message
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
