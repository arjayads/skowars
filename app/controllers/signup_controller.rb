class SignupController < ApplicationController

  def index
    types = {skowar: "Skowar", sponsor: "Sponsor"}
    @type = types[params[:type].to_sym]
    if !@type
      redirect_to root_path
    end
  end
end
