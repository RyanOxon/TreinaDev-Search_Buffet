require 'rails_helper'

RSpec.describe Customer, type: :model do
  context "#valid?" do
    it "cpf must have correct verification digits " do
      customer = Customer.new(cpf: 13551243412, email: 'a@a.com', password: 'password' )

      expect(customer.valid?).to be_falsey 
    end

    it "cpf must have 11 digits " do
      customer = Customer.new(cpf: 12, email: 'a@a.com', password: 'password' )
      customer_1 = Customer.new(cpf: 1231313131313, email: 'aa@a.com', password: 'password' )
      expect(customer.valid?).to be_falsey 
      expect(customer_1.valid?).to be_falsey 
    end
    
    it "must be unique" do
      Customer.create!(cpf: 45575761096, email: 'a@a.com', password: 'password' )
      customer_1 = Customer.new(cpf: 45575761096, email: 'aa@a.com', password: 'password' )

      expect(customer_1.valid?).to be_falsey 

    end
    

  end
  
end
