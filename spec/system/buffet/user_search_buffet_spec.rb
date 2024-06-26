require 'rails_helper'

describe 'User search buffet' do
  context '#visitor' do
    it 'from navbar' do
      visit root_path

      expect(page).to have_field 'Buscar Buffet'
      expect(page).to have_button 'Buscar'
      
    end

    it 'and found buffets by name' do
      load_payments
      load_categories
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      user_2 = BuffetOwner.create!(email: 'r@e.com', password: 'password')
      user_3 = BuffetOwner.create!(email: 'ra@e.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '74107306000188', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find_by(method: "credit_card"))
      buffet_2 = Buffet.create!(brand_name: 'Volcano Buffets', corporate_name: 'Geological fissure LTDA', 
                              registration: '36248768000126', phone_number: '99123456789', 
                              email: 'atendimento@lava.com', address: 'Rua explosion, 123',
                              district: 'underground', city: 'Tectonic rift', state_code: 'TT', 
                              zip_code: '99999-999', description: 'A blast of buffet', 
                              buffet_owner: user_2)
      BuffetPaymentMethod.create!(buffet: buffet_2, payment_method: PaymentMethod.find_by(method: "credit_card"))
      buffet_3 = Buffet.create!(brand_name: 'Comida a kilo', corporate_name: 'Geologica fissure LTDA', 
                              registration: '55092293000176', phone_number: '99123456789', 
                              email: 'atendimento@lava.com', address: 'Rua explosion, 123',
                              district: 'underground', city: 'Tectonic rift', state_code: 'TT', 
                              zip_code: '99999-999', description: 'A blast of buffet', 
                              buffet_owner: user_3)
      BuffetPaymentMethod.create!(buffet: buffet_3, payment_method: PaymentMethod.find_by(method: "credit_card"))

      visit root_path
      fill_in 'Buscar Buffet',	with: 'Buffet' 
      click_on 'Buscar'

      expect(page).to have_content 'Resultados da Busca por: Buffet'
      expect(page).to have_content '2 buffet(s) encontrado(s)'
      expect(page).to have_content 'Galaxy Buffet'
      expect(page).to have_content 'Volcano Buffets'
      expect(page).not_to have_content  'Comida a kilo'  
    end

    it "and found buffets by event type" do
      load_payments
      load_features
      load_categories
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      user_2 = BuffetOwner.create!(email: 'r@e.com', password: 'password')
      user_3 = BuffetOwner.create!(email: 'ra@e.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '28845848000130', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find_by(method: "credit_card"))
      buffet_2 = Buffet.create!(brand_name: 'Volcano Buffets', corporate_name: 'Geological fissure LTDA', 
                              registration: '36248768000126', phone_number: '99123456789', 
                              email: 'atendimento@lava.com', address: 'Rua explosion, 123',
                              district: 'underground', city: 'Tectonic rift', state_code: 'TT', 
                              zip_code: '99999-999', description: 'A blast of buffet', 
                              buffet_owner: user_2)
      BuffetPaymentMethod.create!(buffet: buffet_2, payment_method: PaymentMethod.find_by(method: "credit_card"))
      buffet_3 = Buffet.create!(brand_name: 'Comida a kilo', corporate_name: 'Geologica fissure LTDA', 
                              registration: '55092293000176', phone_number: '99123456789', 
                              email: 'atendimento@lava.com', address: 'Rua explosion, 123',
                              district: 'underground', city: 'Tectonic rift', state_code: 'TT', 
                              zip_code: '99999-999', description: 'A blast of buffet', 
                              buffet_owner: user_3)
      BuffetPaymentMethod.create!(buffet: buffet_3, payment_method: PaymentMethod.find_by(method: "credit_card"))
      event = Event.create!(name: 'Casamento Galaxy Buffet', description: 'um evento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find_by(category: "wedding"),
                          exclusive_address: true, buffet: buffet)
      EventFeature.create!(event: event, feature: Feature.find_by(feature: "alcohol"))
      event_2 = Event.create!(name: 'Casamento Volcano', description: 'um evento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find_by(category: "wedding"),
                          exclusive_address: true, buffet: buffet_2)
      EventFeature.create!(event: event_2, feature: Feature.find_by(feature: "parking_lot"))
      event_3 = Event.create!(name: 'Corporativo a kilo', description: 'um evento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find_by(category: "birthday"),
                          exclusive_address: true, buffet: buffet_3)
      EventFeature.create!(event: event_3, feature: Feature.find_by(feature: "parking_lot"))

      visit root_path
      fill_in 'Buscar Buffet',	with: 'Casamento' 
      click_on 'Buscar'

      expect(page).to have_content 'Resultados da Busca por: Casamento'
      expect(page).to have_content '2 buffet(s) encontrado(s)'
      expect(page).to have_content 'Galaxy Buffet'
      expect(page).to have_content 'Volcano Buffets'
      expect(page).not_to have_content  'Comida a kilo'  
      
    end

    it "and found buffets by city" do
      load_payments
      load_categories
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      user_2 = BuffetOwner.create!(email: 'r@e.com', password: 'password')
      user_3 = BuffetOwner.create!(email: 'ra@e.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '28845848000130', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find_by(method: "credit_card"))
      buffet_2 = Buffet.create!(brand_name: 'Volcano Buffets', corporate_name: 'Geological fissure LTDA', 
                              registration: '36248768000126', phone_number: '99123456789', 
                              email: 'atendimento@lava.com', address: 'Rua explosion, 123',
                              district: 'underground', city: 'Tectonic rift', state_code: 'TT', 
                              zip_code: '99999-999', description: 'A blast of buffet', 
                              buffet_owner: user_2)
      BuffetPaymentMethod.create!(buffet: buffet_2, payment_method: PaymentMethod.find_by(method: "credit_card"))
      buffet_3 = Buffet.create!(brand_name: 'Comida a kilo', corporate_name: 'Geologica fissure LTDA', 
                              registration: '55092293000176', phone_number: '99123456789', 
                              email: 'atendimento@lava.com', address: 'Rua explosion, 123',
                              district: 'underground', city: 'Tectonic rift', state_code: 'TT', 
                              zip_code: '99999-999', description: 'A blast of buffet', 
                              buffet_owner: user_3)
      BuffetPaymentMethod.create!(buffet: buffet_3, payment_method: PaymentMethod.find_by(method: "credit_card"))

      visit root_path
      fill_in 'Buscar Buffet',	with: 'Tectonic rift' 
      click_on 'Buscar'

      expect(page).to have_content 'Resultados da Busca por: Tectonic rift'
      expect(page).to have_content '2 buffet(s) encontrado(s)'
      expect(page).to have_content 'Volcano Buffets'
      expect(page).to have_content 'Comida a kilo'
      expect(page).not_to have_content 'Galaxy Buffet'  


    end

    it 'go directly to buffet if brand name matches exactly' do
      load_payments
      load_features
      load_categories
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      user_2 = BuffetOwner.create!(email: 'r@e.com', password: 'password')
      user_3 = BuffetOwner.create!(email: 'ra@e.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '28845848000130', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find_by(method: "credit_card"))
      buffet_2 = Buffet.create!(brand_name: 'Volcano Buffets', corporate_name: 'Geological fissure LTDA', 
                              registration: '36248768000126', phone_number: '99123456789', 
                              email: 'atendimento@lava.com', address: 'Rua explosion, 123',
                              district: 'underground', city: 'Tectonic rift', state_code: 'TT', 
                              zip_code: '99999-999', description: 'A blast of buffet', 
                              buffet_owner: user_2)
      BuffetPaymentMethod.create!(buffet: buffet_2, payment_method: PaymentMethod.find_by(method: "credit_card"))
      buffet_3 = Buffet.create!(brand_name: 'Comida a kilo', corporate_name: 'Geologica fissure LTDA', 
                              registration: '55092293000176', phone_number: '99123456789', 
                              email: 'atendimento@lava.com', address: 'Rua explosion, 123',
                              district: 'underground', city: 'Tectonic rift', state_code: 'TT', 
                              zip_code: '99999-999', description: 'A blast of buffet', 
                              buffet_owner: user_3)
      BuffetPaymentMethod.create!(buffet: buffet_3, payment_method: PaymentMethod.find_by(method: "credit_card"))

      visit root_path
      fill_in 'Buscar Buffet',	with: 'Galaxy Buffet' 
      click_on 'Buscar'

      expect(page).to have_content "Galaxy Buffet"
      expect(page).not_to have_content "Buffetys LTDA"
      expect(page).to have_content "28845848000130"
      expect(page).to have_content "99123456789"
      expect(page).to have_content "atendimento@buffyts.com"
      expect(page).to have_content "Rua Estrelas, 123"
      expect(page).to have_content "Via lactea"
      expect(page).to have_content "AA"
      expect(page).to have_content "99999-999"
      expect(page).to have_content "Um buffet de outro mundo"
      expect(page).to have_content "Cartão de Credito" 
    end
  end

end
