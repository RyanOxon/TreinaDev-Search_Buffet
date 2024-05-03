class Buffet < ApplicationRecord
  belongs_to :buffet_owner
  has_many :events
  has_many :orders, through: :events
  
  has_many :buffet_payment_methods
  has_many :payment_methods, through: :buffet_payment_methods

  validates :brand_name, :corporate_name, :phone_number, :registration,
            :email, :address, :district, :city, :state_code, :zip_code,
            :description, presence: true
  validates :brand_name, :corporate_name, :registration, uniqueness: true
  validates :state_code, length: {is: 2}
  
end
