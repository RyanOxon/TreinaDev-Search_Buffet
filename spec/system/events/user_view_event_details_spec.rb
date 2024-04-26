require 'rails_helper'

describe 'user view event details' do
  context '#buffet owner' do
    it 'from navbar events list' do
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
      login_as user, scope: :buffet_owner
      
      visit root_path
      within 'nav' do
        click_on 'Lista de Eventos'
      end
      click_on 'Casamento Galaxy Buffet'

      expect(page).to have_content 'Retornar para Galaxy Buffet'
      expect(page).to have_content 'Casamento Galaxy Buffet'
      expect(page).to have_content 'um casamento muito louco'
      expect(page).to have_content 'Capacidade: minimo 20 e maximo 40'
      expect(page).to have_content '4 horas'
      expect(page).to have_content 'um monte de comida'
      expect(page).to have_content 'Bebidas alcoolicas'
      expect(page).to have_content 'Endereço Exclusivo: Sim'

    end

    it 'from buffet details' do
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
      login_as user, scope: :buffet_owner
      
      visit root_path
      click_on 'Casamento Galaxy Buffet'

      expect(page).to have_content 'Retornar para Galaxy Buffet'
      expect(page).to have_content 'Casamento Galaxy Buffet'
      expect(page).to have_content 'um casamento muito louco'
      expect(page).to have_content 'Capacidade: minimo 20 e maximo 40'
      expect(page).to have_content '4 horas'
      expect(page).to have_content 'um monte de comida'
      expect(page).to have_content 'Bebidas alcoolicas'
      expect(page).to have_content 'Endereço Exclusivo: Sim'

    end
  end

  context '#visitor' do
    it 'from buffet details' do
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
      event = Event.create!(name: 'Casamento Galaxy Buffet', description: 'um casamento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find(2),
                          exclusive_address: true, buffet: buffet)
      EventFeature.create!(event: event, feature: Feature.find(1))
      event_3 = Event.create!(name: 'Corporativo Galaxy Buffet', description: 'Buffet para eventos corporativo',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'Comida, comida, comida, comida, bebida, bebida', event_category: EventCategory.find(5),
                          exclusive_address: true, buffet: buffet)
      EventFeature.create!(event: event_3, feature: Feature.find(3))
      EventPrice.create!(price_type: 0, base_value: 10000, extra_per_person: 100, extra_per_hour: 2000, event: event)
      visit root_path
      click_on 'Galaxy Buffet'
      click_on 'Casamento Galaxy Buffet'

      expect(page).to have_content 'Retornar para Galaxy Buffet'
      expect(page).to have_content 'Casamento Galaxy Buffet'
      expect(page).to have_content 'um casamento muito louco'
      expect(page).to have_content 'Capacidade: minimo 20 e maximo 40'
      expect(page).to have_content '4 horas'
      expect(page).to have_content 'um monte de comida'
      expect(page).to have_content 'Bebidas alcoolicas'
      expect(page).to have_content 'Endereço Exclusivo: Sim'
      expect(page).to have_content 'Preço dias de semana'
      expect(page).to have_content 'Valor base: 10000'
      expect(page).to have_content 'Adicional por pessoa: 100'
      expect(page).to have_content 'Adicional por hora: 2000'
  
    end
  end
end