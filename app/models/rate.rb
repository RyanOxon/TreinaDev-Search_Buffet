class Rate < ApplicationRecord
  belongs_to :buffet
  belongs_to :customer

  has_many :holder_images, as: :holder

  validates :score, :comment, :buffet, :customer, presence: true
  before_create :set_rated_at

  def set_rated_at
    self.rated_at = Time.zone.now
  end
end
