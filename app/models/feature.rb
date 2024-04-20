class Feature < ApplicationRecord
  has_many :event_categories
  has_many :events, through: :event_categories
  
  enum feature: {alcohol: 0, decoration: 1, parking_lot: 2, valet: 3, exclusive_address: 4 }
end
