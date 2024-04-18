class Buffet < ApplicationRecord
  belongs_to :buffet_owner
  has_many :buffet_payments_methods
  has_many :payment_methods, through: :buffet_payments_methods
end
