class PaymentMethod < ApplicationRecord
  has_many :buffet_payments_methods
  has_many :buffets, through: :buffet_payments_methods

  enum method: [:cash, :credit_card, :debit_card]
end
