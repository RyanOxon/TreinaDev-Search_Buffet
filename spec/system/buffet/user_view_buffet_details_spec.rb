require 'rails_helper'

describe 'user view buffet details' do
  context "#buffet owner" do
    it "from navbar" do
      load_payments
      user = BuffetOwner.create!(email: 'rafa@el.com', password: "password")
      buffet = Buffet.create!(brand_name: "Galaxy Buffet", corporate_name: "Buffetys LTDA", 
                              registration: "321.543.12/0001-33", phone_number: "99123456789", 
                              email: "atendimento@buffyts.com", address: "Rua Estrelas, 123",
                              district: "Sistema Solar", city: "Via lactea", state_code: "AA", 
                              zip_code: "99999-999", description: "Um buffet de outro mundo", 
                              buffet_owner: user)
      BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find(1))
      login_as user

      visit root_path
      within 'nav' do
        click_on "Meu Buffet"
      end

      expect(page).to have_content "Galaxy Buffet" 
      expect(page).to have_content "Buffetys LTDA"
      expect(page).to have_content "321.543.12/0001-33"
      
    end

    it "after log in" do
      load_payments
      user = BuffetOwner.create!(email: 'rafa@el.com', password: "password")
      buffet = Buffet.create!(brand_name: "Galaxy Buffet", corporate_name: "Buffetys LTDA", 
                              registration: "321.543.12/0001-33", phone_number: "99123456789", 
                              email: "atendimento@buffyts.com", address: "Rua Estrelas, 123",
                              district: "Sistema Solar", city: "Via lactea", state_code: "AA", 
                              zip_code: "99999-999", description: "Um buffet de outro mundo", 
                              buffet_owner: user)
      BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find(1))

      visit root_path

      within 'div#owners' do
      click_on "Logar"
      end

      fill_in "E-mail",	with: "rafa@el.com"
      fill_in "Senha",	with: "password"
      click_on "Log in"

      expect(current_path).to eq buffet_path(buffet.id)
      expect(page).to have_content "Galaxy Buffet" 
      expect(page).to have_content "Buffetys LTDA"
      expect(page).to have_content "321.543.12/0001-33"
      
    end

    it "and cannot force view others buffet" do
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
      visit buffet_path(buffet_2.id)

      expect(current_path).not_to eq buffet_path(buffet_2.id)
      expect(current_path).to eq buffet_path(user.buffet.id)
      expect(page).to have_content 'Acesso não autorizado'
      
    end
  end
  
  context "#visitor" do

    it "from root and cannot see corporate name" do
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
      BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find(1))
      buffet_2 = Buffet.create!(brand_name: 'Volcano Buffets', corporate_name: 'Geological fissure LTDA', 
                              registration: '321.543.12/0001-33', phone_number: '99123456789', 
                              email: 'atendimento@lava.com', address: 'Rua explosion, 123',
                              district: 'underground', city: 'Tectonic rift', state_code: 'TT', 
                              zip_code: '99999-999', description: 'A blast of buffet', 
                              buffet_owner: user_2)
      BuffetPaymentMethod.create!(buffet: buffet_2, payment_method: PaymentMethod.find(1))

      visit root_path
      click_on 'Galaxy Buffet'

      expect(page).to have_content "Galaxy Buffet"
      expect(page).not_to have_content "Buffetys LTDA"
      expect(page).to have_content "321.543.12/0001-33"
      expect(page).to have_content "99123456789"
      expect(page).to have_content "atendimento@buffyts.com"
      expect(page).to have_content "Rua Estrelas, 123"
      expect(page).to have_content "Via lactea"
      expect(page).to have_content "AA"
      expect(page).to have_content "99999-999"
      expect(page).to have_content "Um buffet de outro mundo"
      expect(page).to have_content "Dinheiro"
    end
    
    
  end
  
end