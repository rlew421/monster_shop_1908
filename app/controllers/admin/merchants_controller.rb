class Admin::MerchantsController < Admin::BaseController

  def show
    @merchant = Merchant.find(params[:merchant_id])
    order_ids = Order.joins(:items).where("items.merchant_id = #{@merchant.id}").pluck(:id)
    @orders = Order.find(order_ids)
  end

  def index
    @merchants = Merchant.all
  end

  def enable
    merchant = Merchant.find(params[:id])
    merchant.enable
  end

  def disable
    merchant = Merchant.find(params[:id])
    merchant.disable
  end

  # !!Move into the Model!!
  def update_status
    merchant = Merchant.find(params[:merchant_id])
    if merchant.enabled? == false
      merchant.enable
      merchant.items.each do |item|
        item.update_column(:active?, true)
      end
      flash[:success] = "#{merchant.name} is now enabled."
    elsif merchant.enabled?
      merchant.disable
      merchant.items.each do |item|
        item.update_column(:active?, false)
      end
      flash[:success] = "#{merchant.name} is now disabled."
    end
    redirect_to '/merchants'
  end


end
