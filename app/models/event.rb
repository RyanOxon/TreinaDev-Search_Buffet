class Event < ApplicationRecord
  belongs_to :buffet
  belongs_to :event_category
  belongs_to :cover_photo, class_name: 'HolderImage', optional: true, foreign_key: 'photo_id'

  has_many :holder_images, as: :holder, dependent: :destroy
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

  def set_features(ids)
    self.features.destroy_all
    ids.each do |id|
      feature = Feature.find(id)
      EventFeature.create!(event: self, feature: feature) unless feature.nil?
    end
  end
end