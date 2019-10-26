class Employment < ApplicationRecord
  belongs_to :merchant
  belongs_to :user

  def self.creation(user, merchant_id)
    self.create!(user_id: user.id, merchant_id: merchant_id.to_i)
  end
end
