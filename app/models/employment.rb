class Employment < ApplicationRecord
  belongs_to :merchant
  belongs_to :user

  validates_presence_of :user_id, :merchant_id

  def self.creation(user, merchant_id)
    self.create!(user_id: user.id, merchant_id: merchant_id)
  end
end