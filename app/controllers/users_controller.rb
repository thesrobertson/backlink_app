class UsersController < ApplicationController
  skip_before_action :check_user_whitelist, only: [:new, :create]
  before_action :require_admin, except: [:new]

  def index
    @users = User.all
  end

  def new

    if User.exists?(email:  session[:user_email])
      redirect_to backlinks_home_path
    end
  end

   def create
    @user = User.new(email: params[:user][:email], password: 'password') # Set default password for non-admin users
    if @user.save
      flash[:success] = "User created successfully"
      redirect_to users_path
    else
      flash.now[:alert] = "Error creating user"
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    @user.assign_attributes(email: params[:user][:email])

    # Force save without validation checks
    if @user.save(validate: false) # Skip validation to avoid uniqueness constraint issues
      redirect_to users_path, notice: 'User updated successfully'
    else
      redirect_to users_path, alert: 'Failed to update user' # This is unlikely to hit due to skip validations
    end
  end

   def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: "User removed successfully"
  end
  
  private
  def require_admin
  unless session[:admin]
    redirect_to login_path, alert: "You must be logged in as admin to perform this action"
  end
end

end


