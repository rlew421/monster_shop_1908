class Employment < ApplicationRecord
  belongs_to :merchant
  belongs_to :user

end
