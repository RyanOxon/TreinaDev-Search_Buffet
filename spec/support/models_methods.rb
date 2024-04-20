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

def load_categories
  EventCategory.categories.keys.each do |category|
    EventCategory.create!(category: category)
  end
end