class SignupController < ApplicationController

  def index
    cats = {skowar: "Skowar", sponsor: "Sponsor"}
    param_cat = cats[params[:type].to_sym]
    if !param_cat
      redirect_to root_path
    end
    @member = Member.new(category: param_cat)
  end

  def create
    @member = Member.new(member_params)
    if @member.save
      @member.send_activation_email
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
