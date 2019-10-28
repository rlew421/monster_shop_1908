class Merchant::ItemsController < Merchant::BaseController

  def index
    merchant = Merchant.find(current_user.merchant_id)
    @items = merchant.items
  end

  def new
  end

  def create
    merchant = Merchant.find(current_user.merchant_id)
    @new_item = merchant.items.new(item_params)
    if @new_item.save
      flash[:success] = "#{@new_item.name} is saved to your items."
      redirect_to '/merchant/items'
    else
      flash[:error] = @new_item.errors.full_messages.to_sentence
      render :new
    end
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

  private

  def item_params
    params.permit(Item.column_names)
  end
end
