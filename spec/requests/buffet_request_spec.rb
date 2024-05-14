require 'rails_helper'

describe "requests for buffet" do
  context "#update" do
    it "and its not the owner" do
      load_payments()
      user = BuffetOwner.create!(email: 'r@fael.com', password: "password")
      user_2 = BuffetOwner.create!(email: 'raf@el.com', password: "password")
      buffet = Buffet.create!(brand_name: "Galaxy Buffet", corporate_name: "Buffetys LTDA", registration: "321.543.12/0001-33",
                              phone_number: "99123456789", email: "atendimento@buffyts.com", address: "Rua Estrelas, 123",
                              district: "Sistema Solar", city: "Via lactea", state_code: "AA", zip_code: "99999-999",
                              description: "Um buffet de outro mundo", buffet_owner: user)
      Buffet.create!(brand_name: 'Volcano Buffets', corporate_name: 'Geological fissure LTDA', 
                    registration: '321.543.12/0001-32', phone_number: '99123456789', 
                    email: 'atendimento@lava.com', address: 'Rua explosion, 123',
                    district: 'underground', city: 'Tectonic rift', state_code: 'TT', 
                    zip_code: '99999-999', description: 'A blast of buffet', 
                    buffet_owner: user_2)
      BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find_by(method: "cash"))
      
      login_as user_2, scope: :buffet_owner
      patch buffet_path(buffet.id), params: {buffet: { brand_name: 'Edited Buffet'}}

      expect(response).to redirect_to user_2.buffet
    end
  end

end
