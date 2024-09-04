class UsersController < ApplicationController
  skip_before_action :check_user_whitelist, only: [:new, :create]

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
end
