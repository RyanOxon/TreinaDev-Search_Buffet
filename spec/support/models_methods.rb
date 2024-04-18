def load_payments
  PaymentMethod.create!(method: 0)
  PaymentMethod.create!(method: 1)
  PaymentMethod.create!(method: 2)
end