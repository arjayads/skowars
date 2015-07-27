class MemberController < ApplicationController
  before_action :logged_in_user, only: [:new]

  def index
  end

  def show
    if !logged_in?
      redirect_to signin_path
    end
  end

  def new
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
      flash[:success] = true
      redirect_to after_signup_path
    else
      render :action => 'new'
    end
  end

  def change_profile_pic
    img = params[:imageData].gsub('data:image/jpeg;base64,', '')
    img = img.gsub(' ', '+')
    img = Base64.decode64(img)
    filename = 'uploads/' + Digest::MD5.hexdigest(img) + '.jpeg'

    File.open(filename, 'wb') do|f|
      f.write(img)
    end
    render :text => filename
  end

  private
  def member_params
    params.require(:member).permit(:first_name, :last_name, :email, :password, :password_confirmation, :category, :gender)
  end

  # Confirms a logged-in user.
  def logged_in_user
    if logged_in?
      redirect_to member_profile_path
    end
  end
end
