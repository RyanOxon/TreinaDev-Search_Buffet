class BuffetPaymentMethod < ApplicationRecord
  belongs_to :buffet
  belongs_to :payment_method

  validates :buffet_id, :payment_method_id, presence: true
end
