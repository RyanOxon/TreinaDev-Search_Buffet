class Buffet < ApplicationRecord
  belongs_to :buffet_owner
  has_many :payment_methods
  has_many :buffet_paymentes_method
end
