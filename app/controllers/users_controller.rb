class UsersController < ApplicationController
  skip_before_action :check_user_whitelist, only: [:new, :create]
  before_action :require_admin, except: [:create]

  def index
    @users = User.all
  end

  def new
  end

  def create
    if User.exists?(email: params[:email])
      session[:user_email] = params[:email]
      redirect_to backlinks_path, notice: "Welcome!"
    else
      flash.now[:alert] = "Unfortunately you do not have access to this application. Please contact: az@linkzenit.com for access."
      render :new
    end
  end
  private
  def require_admin
  unless session[:admin]
    redirect_to login_path, alert: "You must be logged in as admin to perform this action"
  end
end

end


