class SessionsController < ApplicationController

  def reset
    reset_session
    redirect_to root_path
  end
end
