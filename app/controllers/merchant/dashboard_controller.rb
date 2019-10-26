class Merchant::DashboardController < Merchant::BaseController
  def show
    @user = User.find(session[:user_id])
  end
end
