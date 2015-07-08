class SessionsController < ApplicationController

  def logout
    log_out if logged_in?
    redirect_to root_url
  end

  def signin
    if logged_in?
      redirect_to member_profile_path
    end
  end

  def create
    member = Member.find_by(email: params[:session][:email])
    if member && member.authenticate(params[:session][:password])
      log_in member
      params[:session][:remember_me] == '1' ? remember(member) : forget(member)
      redirect_to member_profile_path
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'signin'
    end
  end

end
