class Order < ApplicationRecord
  before_create :generate_code
  belongs_to :event
  belongs_to :customer

  enum status: { waiting: 0, confirmed: 1, canceled: 2 }

  def humanized_status_name
    I18n.t("activerecord.attributes.order.status.#{self.status}")
  end

  private 

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end

end
