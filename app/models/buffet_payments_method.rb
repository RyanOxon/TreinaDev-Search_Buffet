class BuffetPaymentsMethod < ApplicationRecord
  belongs_to :buffet
  belongs_to :payment_methods
end
