class Buffet < ApplicationRecord
  belongs_to :buffet_owner
  has_many :events
  has_many :holder_images, through: :events
  has_many :orders, through: :events
  has_many :messages, as: :user
  has_many :rates
  has_many :buffet_payment_methods
  has_many :payment_methods, through: :buffet_payment_methods

  validates :brand_name, :corporate_name, :phone_number, :registration,
            :email, :address, :district, :city, :state_code, :zip_code,
            :description, presence: true
  validates :brand_name, :corporate_name, :registration, uniqueness: true
  validates :state_code, length: {is: 2}
  validate :check_cnpj


  def check_same_date_orders(order)
    self.orders.where(date: order.date).where(status: ["waiting", "negotiating"])
                                      .where.not(id: order.id).exists?
  end

  def average_rate
    return '' if rates.empty?
    self.rates.average(:score).round(1)
  end
  
  def check_cnpj
    cnpj = self.registration.gsub(/[^0-9]/, '')
    if cnpj.length != 14 || cnpj.chars.uniq.size == 1
      errors.add(:registration, 'não é valido')
    end

    pesos1 = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
    pesos2 = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]

    soma1 = cnpj[0..11].chars.each_with_index.sum { |char, index| char.to_i * pesos1[index] }
    digito1 = soma1 % 11 < 2 ? 0 : 11 - (soma1 % 11)
    soma2 = cnpj[0..11].chars.each_with_index.sum { |char, index| char.to_i * pesos2[index] } + digito1 * pesos2[12]
    digito2 = soma2 % 11 < 2 ? 0 : 11 - (soma2 % 11)
    unless digito1 == cnpj[12].to_i && digito2 == cnpj[13].to_i
      errors.add(:registration, 'não é valido')
    end

  end

end
