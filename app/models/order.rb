class Order < ApplicationRecord
  before_create :generate_code
  belongs_to :event
  belongs_to :customer

  validates :date, :people_count, presence: true
  validate :date_is_future

  enum status: { waiting: 0, confirmed: 1, canceled: 2 }

  def humanized_status_name
    I18n.t("activerecord.attributes.order.status.#{self.status}")
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
