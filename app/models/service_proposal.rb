class ServiceProposal < ApplicationRecord
  belongs_to :order

  enum status: { waiting: 0, rejected: 1, confirmed: 2, canceled: 3 }

  def humanized_status_name
    I18n.t("activerecord.attributes.service_proposal.status.#{self.status}")
  end

  def get_real_value
    self.value + self.extra_fee - self.discount
  end

end
