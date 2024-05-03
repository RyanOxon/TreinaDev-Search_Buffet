class Event < ApplicationRecord
  belongs_to :buffet
  belongs_to :event_category

  has_many :event_prices
  has_many :event_features
  has_many :features, through: :event_features
  has_many :orders

  validates :name, :description, :min_capacity, :max_capacity, :default_duration,
            :menu, presence: true
  
  validates :name, uniqueness: true

end
