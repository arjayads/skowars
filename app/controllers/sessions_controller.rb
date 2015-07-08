class SessionsController < ApplicationController

  def logout
    reset_session
    redirect_to root_path
  end

  def signin
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user

      redirect_to root_path
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
end
