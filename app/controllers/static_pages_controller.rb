class StaticPagesController < ApplicationController

  def index
    if logged_in?
      redirect_to member_profile_path
    end
  end

  def activation_result
  end
end
