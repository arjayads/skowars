class SessionsController < ApplicationController

  def logout
    reset_session
    redirect_to root_path
  end

  def signin
  end

  def create
    member = Member.find_by(email: params[:session][:email])
    if member && member.authenticate(params[:session][:password])
      log_in member
      redirect_to member_profile_path
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'signin'
    end
  end
end
