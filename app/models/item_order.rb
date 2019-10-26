class ItemOrder < ApplicationRecord
  validates_presence_of :item_id, :order_id, :price, :quantity, :status

  belongs_to :item
  belongs_to :order

  def subtotal
    price * quantity
  end

  def self.fulfillment(item_id, order_id)
    self.where(item_id: item_id).where(order_id: order_id).update(status: 'fulfilled')

    this_order = self.where(order_id: order_id)
    if this_order.all?{|item_order| item_order[:status] == 'fulfilled'}
      Order.fulfill(order_id)
    end
  end
end
