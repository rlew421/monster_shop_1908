class Merchant::DashboardController < Merchant::BaseController
  def show
    @user = User.find(params[:merchant_id])
  end
end
