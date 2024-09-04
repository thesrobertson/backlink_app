class ApplicationController < ActionController::Base
  before_action :check_user_whitelist

  private

  def check_user_whitelist
    unless session[:user_email].present? && User.exists?(email: session[:user_email])
      reset_session
      redirect_to new_user_path, alert: "Please enter your email to continue"
    end
  end
end