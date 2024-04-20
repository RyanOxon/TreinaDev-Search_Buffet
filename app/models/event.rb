class Event < ApplicationRecord
  belongs_to :buffet

  has_many :event_features
  has_many :features, through: :event_features
  has_one :event_categories

end
