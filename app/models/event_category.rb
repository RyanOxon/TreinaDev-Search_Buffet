class EventCategory < ApplicationRecord
  has_many :events

  validates :category, presence: true
  validates :category, uniqueness: true

  enum category: {debutante_ball: 0, wedding: 1, conferences: 2, congresses: 3,
                  corporate: 4, birthday: 5, baby_shower: 6, gaduations: 7, 
                  inaugurations: 8 }

  def humanized_category_name
    I18n.t("activerecord.attributes.event_category.category.#{self.category}")
  end

  def self.revert_i18n(translated_category)
    categories_i18n = EventCategory.categories.keys.map {|key| [
                      I18n.t("activerecord.attributes.event_category.category.#{key}"), key]}.to_h
    EventCategory.categories[categories_i18n[translated_category]]
  end
  
end
