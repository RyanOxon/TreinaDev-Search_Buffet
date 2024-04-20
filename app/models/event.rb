class Event < ApplicationRecord
  belongs_to :buffet
  belongs_to :event_category
  
  has_many :event_features
  has_many :features, through: :event_features
  

end
