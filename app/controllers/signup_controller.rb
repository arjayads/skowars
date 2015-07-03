class SignupController < ApplicationController

  def index
    types = {skowar: "Skowar", sponsor: "Sponsor"}
    if !types[params[:type].to_sym]
      redirect_to root_path
    end
    @member = Member.new(category: params[:type])
  end

  def create
    @member = Member.new(member_params)
    @member.is_active = true
    if @member.save
      redirect_to root_path
    else
      render :action => 'index'
    end
  end

  private
  def member_params
    params.require(:member).permit(:first_name, :last_name, :email, :password, :password_confirmation, :category)
  end
end
