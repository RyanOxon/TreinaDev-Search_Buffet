require 'rails_helper'

RSpec.describe BuffetPaymentMethod, type: :model do
  describe "#valid?" do
    it "false when method is empty" do
      buffet = Buffet.new(brand_name: "Buffet Galatico", corporate_name: "Buffetys LTDA", registration: "321.543.12/0001-33",
                        phone_number: "99123456789", email: "atendimento@buffyts.com", address: "Rua Estrelas, 123",
                        district: "Sistema Solar", city: "Via lactea", state_code: "AA", zip_code: "",
                        description: "Um buffet de outro mundo" )

      buffet_payment_method = BuffetPaymentMethod.new(buffet: buffet)

      expect(buffet_payment_method.valid?).to be_falsey
    end

    it "false when buffet is empty" do
      method = PaymentMethod.new(method: 1)

      buffet_payment_method = BuffetPaymentMethod.new(payment_method: method)

      expect(buffet_payment_method.valid?).to be_falsey
    end
  end
end
