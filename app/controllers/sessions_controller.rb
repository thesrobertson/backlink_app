class SessionsController < ApplicationController
  skip_before_action :check_user_whitelist

  def new
  end

  def create
    if params[:username] == 'az@linkzenit.com' && params[:password] == 'Linkxdeal2024'
      session[:admin] = true
      redirect_to admin_dashboard_path, notice: "Logged in successfully"
    else
      flash.now[:alert] = "Invalid username or password"
      render :new
    end
  end

  def destroy
    session[:admin] = nil
    redirect_to login_path, notice: "Logged out successfully"
  end
end
