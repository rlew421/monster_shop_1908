class Admin::DashboardController < Admin::BaseController
  def show
    @user = User.find(session[:user_id])
  end

  def index
    @users = User.where(role: 'default')
  end
end
