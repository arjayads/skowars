class StaticPagesController < ApplicationController

  def index
    if session[:user_id]
      redirect_to member_profile_path
    end
  end

  def activation_result
  end
end
