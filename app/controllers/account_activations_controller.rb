class AccountActivationsController < ApplicationController

  def edit
    member = Member.find_by(email: params[:email])

    if member && !member.is_active && member.authenticated?(:activation, params[:id])
      member.activate
      log_in member
      flash[:success] = 'Account activated!'
    else
      flash[:danger] = 'Invalid activation link'
    end
    redirect_to activation_result_url
  end
end
