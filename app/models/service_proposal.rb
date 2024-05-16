class ServiceProposal < ApplicationRecord
  belongs_to :order

  validates :value, :expiration_date, presence: true
  validate :exp_date_is_future, on: :create

  enum status: { waiting: 0, rejected: 1, confirmed: 2, canceled: 3 }

  def humanized_status_name
    I18n.t("activerecord.attributes.service_proposal.status.#{self.status}")
  end

  def get_real_value
    self.value + self.extra_fee - self.discount
  end

  def exp_date_is_future
    if self.expiration_date.present? && self.expiration_date < Date.today
      self.errors.add(:expiration_date, "deve ser futura.")
    end
  end
end