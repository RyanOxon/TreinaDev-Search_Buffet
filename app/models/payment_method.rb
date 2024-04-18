class PaymentMethod < ApplicationRecord
  has_many :buffet
  has_many :buffet_paymentes_method

  enum method: [:cash, :credit_card, :debit_card]

end
