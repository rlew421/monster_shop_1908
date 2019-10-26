class Order <ApplicationRecord
  belongs_to :user

  validates_presence_of :name, :address, :city, :state, :zip, :status

  has_many :item_orders
  has_many :items, through: :item_orders

  def grandtotal
    item_orders.sum('price * quantity')
  end

  def item_count
    items.length
  end

  def self.fulfill(order_id)
    Order.where(id: order_id).update(status: 'fulfilled')
  end
end
