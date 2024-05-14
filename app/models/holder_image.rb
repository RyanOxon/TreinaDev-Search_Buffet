class HolderImage < ApplicationRecord
  belongs_to :holder, polymorphic: true
  belongs_to :user, polymorphic: true
  has_one_attached :image 
  
end
