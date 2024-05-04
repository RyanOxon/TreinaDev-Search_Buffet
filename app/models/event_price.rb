class EventPrice < ApplicationRecord
  belongs_to :event

  validates :price_type, :base_value, :extra_per_person, :extra_per_hour, presence: true

  enum price_type: {standard: 0, special: 1}

  def humanized_price_name
    I18n.t("activerecord.attributes.event_price.price_type.#{self.price_type}")
  end
end
