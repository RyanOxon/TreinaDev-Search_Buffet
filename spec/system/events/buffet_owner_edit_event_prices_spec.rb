require 'rails_helper'

describe "Buffet owner edit event prices" do
  context "#standard price" do
    it "from event details" do
      load_payments
      load_features
      load_categories
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '321.543.12/0001-33', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find(2))
      event = Event.create!(name: 'Eventinho', description: 'um evento muito louco',
                            min_capacity: 20, max_capacity: 40, default_duration: 240,
                            menu: 'um monte de comida', event_category: EventCategory.find(2),
                            exclusive_address: true, buffet: buffet)
      EventFeature.create!(event: event, feature: Feature.find(1))
      event_2 = Event.create!(name: 'Eventão', description: 'um evento muito quente',
                            min_capacity: 20, max_capacity: 40, default_duration: 240,
                            menu: 'um monte de comida', event_category: EventCategory.find(5),
                            exclusive_address: true, buffet: buffet)
      EventFeature.create!(event: event_2, feature: Feature.find(2))
      event_3 = Event.create!(name: 'Casamento Galaxy Buffet', description: 'um casamento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find(2),
                          exclusive_address: true, buffet: buffet)
      EventFeature.create!(event: event_3, feature: Feature.find(1))
      EventPrice.create!(price_type: 0, base_value: 10000, extra_per_person: 100, extra_per_hour: 2000, event: event_3)
      login_as user
      
      visit root_path
      click_on 'Casamento Galaxy Buffet'
      click_on 'Atualizar Preço dias de semana'

      expect(page).to have_field 'Valor base'
      expect(page).to have_field 'Adicional por pessoa'
      expect(page).to have_field 'Adicional por hora'
      
    end 

    it "sucessfully" do
      load_payments
      load_features
      load_categories
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '321.543.12/0001-33', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find(2))
      event = Event.create!(name: 'Eventinho', description: 'um evento muito louco',
                            min_capacity: 20, max_capacity: 40, default_duration: 240,
                            menu: 'um monte de comida', event_category: EventCategory.find(2),
                            exclusive_address: true, buffet: buffet)
      EventFeature.create!(event: event, feature: Feature.find(1))
      event_2 = Event.create!(name: 'Eventão', description: 'um evento muito quente',
                            min_capacity: 20, max_capacity: 40, default_duration: 240,
                            menu: 'um monte de comida', event_category: EventCategory.find(5),
                            exclusive_address: true, buffet: buffet)
      EventFeature.create!(event: event_2, feature: Feature.find(2))
      event_3 = Event.create!(name: 'Casamento Galaxy Buffet', description: 'um casamento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find(2),
                          exclusive_address: true, buffet: buffet)
      EventFeature.create!(event: event_3, feature: Feature.find(1))
      EventPrice.create!(price_type: 0, base_value: 10000, extra_per_person: 100, extra_per_hour: 2000, event: event_3)
      login_as user
      
      visit root_path
      click_on 'Casamento Galaxy Buffet'
      click_on 'Atualizar Preço dias de semana'

      fill_in "Valor base",	with: "15000" 
      fill_in "Adicional por pessoa",	with: "150" 
      fill_in "Adicional por hora",	with: "2500" 
      click_on "Definir Valor"

      expect(page).to have_content 'Preço padrão ajustado'
      expect(page).to have_content 'Preço dias de semana'
      expect(page).to have_content 'Valor base: 15000'
      expect(page).to have_content 'Adicional por pessoa: 150'
      expect(page).to have_content 'Adicional por hora: 2500'
      
    end

    xit 'with incomplete data' do
      
    end
  end
  
  context "#special price" do
    it "from event details" do
      load_payments
      load_features
      load_categories
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '321.543.12/0001-33', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find(2))
      event = Event.create!(name: 'Eventinho', description: 'um evento muito louco',
                            min_capacity: 20, max_capacity: 40, default_duration: 240,
                            menu: 'um monte de comida', event_category: EventCategory.find(2),
                            exclusive_address: true, buffet: buffet)
      EventFeature.create!(event: event, feature: Feature.find(1))
      event_2 = Event.create!(name: 'Eventão', description: 'um evento muito quente',
                            min_capacity: 20, max_capacity: 40, default_duration: 240,
                            menu: 'um monte de comida', event_category: EventCategory.find(5),
                            exclusive_address: true, buffet: buffet)
      EventFeature.create!(event: event_2, feature: Feature.find(2))
      event_3 = Event.create!(name: 'Casamento Galaxy Buffet', description: 'um casamento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find(2),
                          exclusive_address: true, buffet: buffet)
      EventFeature.create!(event: event_3, feature: Feature.find(1))
      EventPrice.create!(price_type: 1, base_value: 10000, extra_per_person: 100, extra_per_hour: 2000, event: event_3)
      login_as user
      
      visit root_path
      click_on 'Casamento Galaxy Buffet'
      click_on 'Atualizar Preço final de semana e feriados'

      expect(page).to have_field 'Valor base'
      expect(page).to have_field 'Adicional por pessoa'
      expect(page).to have_field 'Adicional por hora'
      
    end 

    it "sucessfully" do
      load_payments
      load_features
      load_categories
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '321.543.12/0001-33', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find(2))
      event = Event.create!(name: 'Eventinho', description: 'um evento muito louco',
                            min_capacity: 20, max_capacity: 40, default_duration: 240,
                            menu: 'um monte de comida', event_category: EventCategory.find(2),
                            exclusive_address: true, buffet: buffet)
      EventFeature.create!(event: event, feature: Feature.find(1))
      event_2 = Event.create!(name: 'Eventão', description: 'um evento muito quente',
                            min_capacity: 20, max_capacity: 40, default_duration: 240,
                            menu: 'um monte de comida', event_category: EventCategory.find(5),
                            exclusive_address: true, buffet: buffet)
      EventFeature.create!(event: event_2, feature: Feature.find(2))
      event_3 = Event.create!(name: 'Casamento Galaxy Buffet', description: 'um casamento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find(2),
                          exclusive_address: true, buffet: buffet)
      EventFeature.create!(event: event_3, feature: Feature.find(1))
      EventPrice.create!(price_type: 1, base_value: 10000, extra_per_person: 100, extra_per_hour: 2000, event: event_3)
      login_as user
      
      visit root_path
      click_on 'Casamento Galaxy Buffet'
      click_on 'Atualizar Preço final de semana e feriados'

      fill_in "Valor base",	with: "15000" 
      fill_in "Adicional por pessoa",	with: "150" 
      fill_in "Adicional por hora",	with: "2500" 
      click_on "Definir Valor"

      expect(page).to have_content 'Preço especial ajustado'
      expect(page).to have_content 'Preço final de semana e feriados'
      expect(page).to have_content 'Valor base: 15000'
      expect(page).to have_content 'Adicional por pessoa: 150'
      expect(page).to have_content 'Adicional por hora: 2500'
    end

    xit 'with incomplete data' do
      
    end
  end
end