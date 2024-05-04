class Order < ApplicationRecord
  before_create :generate_code
  belongs_to :event
  belongs_to :customer
  has_one :service_proposal

  validates :date, :people_count, presence: true
  validate :date_is_future

  enum status: { waiting: 0, negotiating: 1, confirmed: 2, canceled: 3 }

  def humanized_status_name
    I18n.t("activerecord.attributes.order.status.#{self.status}")
  end

  def calculate_value(type)
    value = 0
    event_price = self.event.event_prices.find_by(price_type: type)
    if event_price
      value += event_price.base_value 
      value += event_price.extra_per_person * ([self.people_count - self.event.min_capacity , 0].max)
    end
    value
  end

  private 

  def date_is_future
    if self.date.present? && self.date < Date.today
      self.errors.add(:date, "deve ser futura.")
    end
  end

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end

end
