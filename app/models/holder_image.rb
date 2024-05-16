class HolderImage < ApplicationRecord
  belongs_to :holder, polymorphic: true
  belongs_to :user, polymorphic: true
  has_one_attached :image

  validates :image, :user, :holder, presence: true
  before_create :set_uploaded_at

  def set_event(event, buffet_owner)
    self.holder = event
    self.user = buffet_owner
  end

  def set_rate(rate, customer)
    self.holder = rate
    self.user = customer
  end

  private
  def set_uploaded_at
    self.uploaded_at = Time.zone.now
  end
end
