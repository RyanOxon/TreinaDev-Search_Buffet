def load_payments
  PaymentMethod.methods.keys.each do |method|
    PaymentMethod.create!(method: method)
  end
end

def load_features
  Feature.features.keys.each do |feature|
    Feature.create!(feature: feature)
  end
end