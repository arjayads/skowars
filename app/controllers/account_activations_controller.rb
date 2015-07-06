class AccountActivationsController < ApplicationController
  def edit
    member = Member.find_by(email: params[:email])
    if member && !member.is_active && member.authenticated?(:activation, params[:id])
      member.activate
      # log_in member
      flash[:success] = "Account activated!"
      redirect_to root_url
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end
