class AdminController < ApplicationController
  before_action :require_admin

  def dashboard
    @backlinks = Backlink.all
  end

  private

  def require_admin
    unless session[:admin]
      redirect_to login_path, alert: "You must be logged in as admin to access this page."
    end
  end
end
