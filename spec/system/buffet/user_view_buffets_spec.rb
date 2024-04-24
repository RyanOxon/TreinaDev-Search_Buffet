require 'rails_helper'

describe "User view buffets" do
  context "#buffet owner" do
    it "and redirect to own buffet" do
      load_payments
      load_features
      load_categories
      user_2 = BuffetOwner.create!(email: 'r@e.com', password: 'password')
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '321.543.12/0001-33', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find(2))
      buffet_2 = Buffet.create!(brand_name: 'Volcano Buffets', corporate_name: 'Geological fissure LTDA', 
                              registration: '321.543.12/0001-33', phone_number: '99123456789', 
                              email: 'atendimento@lava.com', address: 'Rua explosion, 123',
                              district: 'underground', city: 'Vtectonic rift', state_code: 'TT', 
                              zip_code: '99999-999', description: 'A blast of buffet', 
                              buffet_owner: user_2)
      BuffetPaymentMethod.create!(buffet: buffet_2, payment_method: PaymentMethod.find(2))
      
      login_as user
      visit root_path

      expect(current_path).to eq buffet_path(user.buffet.id)
      expect(page).to have_content 'Galaxy Buffet'
    end
    
  end
  
  context "#visitor" do
    it "from root page" do
      load_payments
      load_features
      load_categories      
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      user_2 = BuffetOwner.create!(email: 'r@e.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '321.543.12/0001-33', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find(2))
      buffet_2 = Buffet.create!(brand_name: 'Volcano Buffets', corporate_name: 'Geological fissure LTDA', 
                              registration: '321.543.12/0001-33', phone_number: '99123456789', 
                              email: 'atendimento@lava.com', address: 'Rua explosion, 123',
                              district: 'underground', city: 'Tectonic rift', state_code: 'TT', 
                              zip_code: '99999-999', description: 'A blast of buffet', 
                              buffet_owner: user_2)
      BuffetPaymentMethod.create!(buffet: buffet_2, payment_method: PaymentMethod.find(2))

      visit root_path

      expect(page).to have_content 'Galaxy Buffet'
      expect(page).to have_content 'Via lactea | AA'
      expect(page).to have_content 'Volcano Buffets'
      expect(page).to have_content 'Tectonic rift | TT'
      
    end
  end
  
end