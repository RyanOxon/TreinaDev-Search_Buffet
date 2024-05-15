class Message < ApplicationRecord
  belongs_to :order
  belongs_to :user, polymorphic: true

  validates :content, :order, :user, presence: true
  validate :set_posted_at

  private
  def set_posted_at
    self.posted_at = Time.now
  end
end
