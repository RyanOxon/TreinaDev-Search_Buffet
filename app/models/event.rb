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

  def date_available?(date_string)
    date = Date.parse(date_string)
    return false if date <= Date.today
    proposals = buffet.orders.where(date: date).where(status: ['negotiating', 'confirmed'])
    return false if proposals.any?
    true
  end

  def capacity_available?(num_people)
    return num_people.to_i <= max_capacity
  end

end