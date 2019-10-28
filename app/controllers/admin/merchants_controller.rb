class Admin::MerchantsController < Admin::BaseController
  def show
    @merchant = Merchant.find(params[:merchant_id])
    order_ids = Order.joins(:items).where("items.merchant_id = #{@merchant.id}").pluck(:id)
    @orders = Order.find(order_ids)
  end
end
