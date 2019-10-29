class Merchant::OrdersController < Merchant::BaseController


  def show
    @order = Order.find(params[:order_id])
    @user = User.find(@order.user_id)
    @items = @order.items.where("items.merchant_id = #{current_user.merchant_id}")
  end


end
