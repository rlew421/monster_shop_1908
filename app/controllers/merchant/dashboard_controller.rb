class Merchant::DashboardController < Merchant::BaseController
  def show
    @user = User.find(session[:user_id])
    @merchant = @user.merchants.first
    order_ids = Order.joins(:items).where("items.merchant_id = #{@merchant.id}").pluck(:id)
    @orders = Order.find(order_ids)
  end
end
