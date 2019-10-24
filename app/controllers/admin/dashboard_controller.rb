class Admin::DashboardController < Admin::BaseController
  def show
    @user = User.find(params[:admin_id])
  end

  def index
    @users = User.where(role: 'default')
  end
end
