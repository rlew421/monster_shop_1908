class Merchant::ItemsController < Merchant::BaseController

  def index
    merchant = current_user.merchants.first
    @items = merchant.items
  end

  def update_status
    item = Item.find(params[:item_id])
    if request.env['PATH_INFO'] == "/merchant/items/#{item.id}/deactivate"
      item.update_column(:active?, false)
      flash[:success] = "#{item.name} is no longer for sale."
    elsif request.env['PATH_INFO'] == "/merchant/items/#{item.id}/activate"
      item.update_column(:active?, true)
      flash[:success] = "#{item.name} is now available for sale."
    end

    redirect_to '/merchant/items'
  end

  def destroy
    item = Item.find(params[:item_id])
    Review.where(item_id: item.id).destroy_all
    item.destroy
    flash[:success] = "#{item.name} has been deleted."

    redirect_to '/merchant/items'
  end
end
