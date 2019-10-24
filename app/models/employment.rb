class Employment < ApplicationRecord
  belongs_to :merchant
  belongs_to :user

  def creation(user, merchant_id)
    self.create!(user_id: user.id, merchant_id: merchant)
    binding.pry
  end
end
