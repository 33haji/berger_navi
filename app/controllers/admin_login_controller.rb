class AdminLoginController < ApplicationController
  def index
  end

  def login
    admin_user = AdminUser.find_by(name: params[:admin_user][:name])
    if admin_user && admin_user.authenticate(params[:admin_user][:password])
      log_in admin_user
      redirect_to root_path
    else
      flash.now[:danger] = 'Invalid name/password combination'
      render 'index'
    end
  end

  def logout
    log_out
    redirect_to root_path
  end
end
