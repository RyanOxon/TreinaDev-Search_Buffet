class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :orders

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :cpf, uniqueness: true
  validate :check_cpf

  private
  def check_cpf
    value = cpf.scan(/[0-9]/).map(&:to_i)
    if value.length == 11 && !DENY_LIST.include?(cpf)
      sum1 = 0
      sum2 = 0
      value[0..8].each_with_index { |val, index| sum1 += val * (10 - index)}
      value[0..9].each_with_index { |val, index| sum2 += val * (11 - index) }
      mod1 = (sum1 % 11 < 2) ? 0 : 11 - sum1 % 11
      mod2 = (sum2 % 11 < 2) ? 0 : 11 - sum2 % 11
      errors.add(:cpf, 'não é valido') unless value[9] == mod1 && value[10] == mod2
    else
      errors.add(:cpf, 'não é valido')
    end
  end

  DENY_LIST = %w[
    00000000000
    11111111111
    22222222222
    33333333333
    44444444444
    55555555555
    66666666666
    77777777777
    88888888888
    99999999999
    12345678909
    01234567890
  ].freeze
end
