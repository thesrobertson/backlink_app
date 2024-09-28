class SessionsController < ApplicationController
  skip_before_action :check_user_whitelist

  def new
  end

 def create
    user = User.find_by(email: params[:username])

    # Check if the user is admin or a regular user with their respective passwords
    if user&.email == 'az@linkzenit.com' && params[:password] == 'Linkxdeal2024'
      session[:user_email] = user.email
      session[:admin] = true
      redirect_to admin_dashboard_path, notice: "Logged in successfully as admin"
    elsif user && user.authenticate(params[:password]) # Check regular user login with 'password'
      session[:user_email] = user.email
      session[:admin] = false
      redirect_to backlinks_home_path, notice: "Logged in successfully"
    else
      flash.now[:alert] = "Invalid username or password"
      render :new
    end
  end

  def destroy
    session.destroy
    session[:admin] = nil
    redirect_to root_path, notice: "Logged out successfully"
  end
end
