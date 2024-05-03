class PaymentMethod < ApplicationRecord
  has_many :buffet_payment_methods
  has_many :buffets, through: :buffet_payment_methods

  validates :method, presence: true
  validates :method, uniqueness: true

  enum method: [:cash, :credit_card, :debit_card, :pix, :paypal]

  def humanized_method_name
    I18n.t("activerecord.attributes.payment_method.method.#{self.method}")
  end
end
