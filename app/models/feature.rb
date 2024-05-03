class Feature < ApplicationRecord
  has_many :event_categories
  has_many :events, through: :event_categories

  validates :feature, presence: true
  validates :feature, uniqueness: true
  
  enum feature: {alcohol: 0, decoration: 1, parking_lot: 2, valet: 3 }

  def humanized_feature_name
    I18n.t("activerecord.attributes.feature.feature.#{self.feature}")
  end
end
