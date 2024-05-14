class BuffetOwner < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :buffet
  has_many :holder_images, as: :user

end
