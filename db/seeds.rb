# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
PaymentMethod.destroy_all
PaymentMethod.methods.keys.each do |method|
  PaymentMethod.create!(method: method)
end

Feature.destroy_all
Feature.features.keys.each do |feature|
  Feature.create!(feature: feature)
end

EventCategory.categories.keys.each do |category|
  EventCategory.create!(category: category)
end