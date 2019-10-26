class Order <ApplicationRecord
  belongs_to :user

  validates_presence_of :name, :address, :city, :state, :zip

  has_many :item_orders
  has_many :items, through: :item_orders

  def grandtotal
    item_orders.sum('price * quantity')
  end

  def item_count
    items.length
  end

  def merchant_item_quantity(merchant)
    item_orders.joins(:items).where("items.merchant_id = #{merchant.id}").sum(:quantity)
  end

  def merchant_total_value(merchant)
    item_orders.joins(:items).where("items.merchant_id = #{merchant.id}").sum('price * quantity')
  end

end
