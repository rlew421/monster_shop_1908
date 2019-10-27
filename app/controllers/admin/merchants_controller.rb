class Admin::MerchantsController < Admin::BaseController

  def update_status
    merchant = Merchant.find(params[:merchant_id])
    if merchant.status == 'disabled'
      merchant.update_column(:status, 'enabled')
      merchant.items.each do |item|
        item.update_column(:active?, true)
      end
      flash[:success] = "#{merchant.name} is now enabled."
    elsif merchant.status == 'enabled'
      merchant.update_column(:status, 'disabled')
      merchant.items.each do |item|
        item.update_column(:active?, false)
      end
      flash[:success] = "#{merchant.name} is now disabled."
    end
    redirect_to '/merchants'
  end

end