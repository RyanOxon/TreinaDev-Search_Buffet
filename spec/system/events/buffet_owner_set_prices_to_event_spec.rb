require 'rails_helper'

describe 'buffet owner set prices to his event' do
  it 'and is not sign in' do
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
    BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find(1))
    event = Event.create!(name: 'Eventinho', description: 'um evento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find(1),
                          exclusive_address: true, buffet: buffet)
    EventFeature.create!(event: event, feature: Feature.find(1))

    visit new_event_price_path

    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

  context '#standard price' do
    it 'from the event details' do
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
      BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find(1))
      event = Event.create!(name: 'Eventinho', description: 'um evento muito louco',
                            min_capacity: 20, max_capacity: 40, default_duration: 240,
                            menu: 'um monte de comida', event_category: EventCategory.find(1),
                            exclusive_address: true, buffet: buffet)
      EventFeature.create!(event: event, feature: Feature.find(1))
      login_as user
      
      visit root_path
      within 'nav' do
        click_on 'Lista de Eventos'
      end
      click_on 'Eventinho'
      click_on 'Definir preço padrão'

      expect(page).to have_field 'Valor base'
      expect(page).to have_field 'Adicional por pessoa'
      expect(page).to have_field 'Adicional por hora'

    end

    it 'sucessfully' do
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
      BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find(1))
      event = Event.create!(name: 'Eventinho', description: 'um evento muito louco',
                            min_capacity: 20, max_capacity: 40, default_duration: 240,
                            menu: 'um monte de comida', event_category: EventCategory.find(1),
                            exclusive_address: true, buffet: buffet)
      EventFeature.create!(event: event, feature: Feature.find(1))
      login_as user
      
      visit root_path
      within 'nav' do
        click_on 'Lista de Eventos'
      end
      click_on 'Eventinho'
      click_on 'Definir preço padrão'
      fill_in 'Valor base',	with: '3000' 
      fill_in 'Adicional por pessoa',	with: '100' 
      fill_in 'Adicional por hora', with: '1000'
      click_on 'Definir Valor'

      expect(current_path).to eq  event_path(event.id)
      expect(page).to have_content 'Preço padrão ajustado'
      expect(page).to have_content 'Preço dias de semana'
      expect(page).to have_content 'Valor base: 3000'
      expect(page).to have_content 'Adicional por pessoa: 100'
      expect(page).to have_content 'Adicional por hora: 1000'
    end

    xit 'with incomplete data' do
    end
    
    
  end
  context '#special price' do
    it 'from the event details' do
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
      BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find(1))
      event = Event.create!(name: 'Eventinho', description: 'um evento muito louco',
                            min_capacity: 20, max_capacity: 40, default_duration: 240,
                            menu: 'um monte de comida', event_category: EventCategory.find(1),
                            exclusive_address: true, buffet: buffet)
      EventFeature.create!(event: event, feature: Feature.find(1))
      login_as user
      
      visit root_path
      within 'nav' do
        click_on 'Lista de Eventos'
      end
      click_on 'Eventinho'
      click_on 'Definir preço especial'

      expect(page).to have_field 'Valor base'
      expect(page).to have_field 'Adicional por pessoa'
      expect(page).to have_field 'Adicional por hora'

    end

    it 'sucessfully' do
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
      BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find(1))
      event = Event.create!(name: 'Eventinho', description: 'um evento muito louco',
                            min_capacity: 20, max_capacity: 40, default_duration: 240,
                            menu: 'um monte de comida', event_category: EventCategory.find(1),
                            exclusive_address: true, buffet: buffet)
      EventFeature.create!(event: event, feature: Feature.find(1))
      login_as user
      
      visit root_path
      within 'nav' do
        click_on 'Lista de Eventos'
      end
      click_on 'Eventinho'
      click_on 'Definir preço especial'
      fill_in 'Valor base',	with: '5000' 
      fill_in 'Adicional por pessoa',	with: '130' 
      fill_in 'Adicional por hora', with: '1500'
      click_on 'Definir Valor'

      expect(current_path).to eq  event_path(event.id)
      expect(page).to have_content 'Preço especial ajustado'
      expect(page).to have_content 'Preço final de semana e feriados'
      expect(page).to have_content 'Valor base: 5000'
      expect(page).to have_content 'Adicional por pessoa: 130'
      expect(page).to have_content 'Adicional por hora: 1500'
    end
    
    xit 'with incomplete data' do
      
    end
  end

end
