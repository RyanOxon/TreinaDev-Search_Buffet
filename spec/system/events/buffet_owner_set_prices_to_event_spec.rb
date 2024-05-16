require 'rails_helper'

describe 'buffet owner set prices to his event' do
  it 'only if authenticated' do
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
    BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find_by(method: "credit_card"))
    event = Event.create!(name: 'Eventinho', description: 'um evento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find_by(category: "wedding"),
                          exclusive_address: true, buffet: buffet)
    EventFeature.create!(event: event, feature: Feature.find_by(feature: "alcohol"))

    visit new_event_event_price_path(event)

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
      BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find_by(method: "credit_card"))
      event = Event.create!(name: 'Eventinho', description: 'um evento muito louco',
                            min_capacity: 20, max_capacity: 40, default_duration: 240,
                            menu: 'um monte de comida', event_category: EventCategory.find_by(category: "wedding"),
                            exclusive_address: true, buffet: buffet)
      EventFeature.create!(event: event, feature: Feature.find_by(feature: "alcohol"))
      login_as user, scope: :buffet_owner
      
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
      BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find_by(method: "credit_card"))
      event = Event.create!(name: 'Eventinho', description: 'um evento muito louco',
                            min_capacity: 20, max_capacity: 40, default_duration: 240,
                            menu: 'um monte de comida', event_category: EventCategory.find_by(category: "wedding"),
                            exclusive_address: true, buffet: buffet)
      EventFeature.create!(event: event, feature: Feature.find_by(feature: "alcohol"))
      login_as user, scope: :buffet_owner
      
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

      expect(page).to have_content 'Preço padrão ajustado'
      expect(current_path).to eq  event_path(event.id)
      expect(page).to have_content 'Preço dias de semana'
      expect(page).to have_content 'Valor base: R$ 3.000,00'
      expect(page).to have_content 'Adicional por pessoa: R$ 100,00'
      expect(page).to have_content 'Adicional por hora: R$ 1.000,00'
    end

    it 'with incomplete data' do
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
      BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find_by(method: "credit_card"))
      event = Event.create!(name: 'Eventinho', description: 'um evento muito louco',
                            min_capacity: 20, max_capacity: 40, default_duration: 240,
                            menu: 'um monte de comida', event_category: EventCategory.find_by(category: "wedding"),
                            exclusive_address: true, buffet: buffet)
      EventFeature.create!(event: event, feature: Feature.find_by(feature: "alcohol"))
      login_as user, scope: :buffet_owner
      
      visit root_path
      within 'nav' do
        click_on 'Lista de Eventos'
      end
      click_on 'Eventinho'
      click_on 'Definir preço padrão'
      fill_in 'Valor base',	with: '' 
      fill_in 'Adicional por pessoa',	with: '100' 
      fill_in 'Adicional por hora', with: '1000'
      click_on 'Definir Valor'

      expect(page).to have_content 'Erro ao ajustar valor'
      expect(page).to have_content 'Valor base não pode ficar em branco'
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
      BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find_by(method: "credit_card"))
      event = Event.create!(name: 'Eventinho', description: 'um evento muito louco',
                            min_capacity: 20, max_capacity: 40, default_duration: 240,
                            menu: 'um monte de comida', event_category: EventCategory.find_by(category: "wedding"),
                            exclusive_address: true, buffet: buffet)
      EventFeature.create!(event: event, feature: Feature.find_by(feature: "alcohol"))
      login_as user, scope: :buffet_owner
      
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
      BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find_by(method: "credit_card"))
      event = Event.create!(name: 'Eventinho', description: 'um evento muito louco',
                            min_capacity: 20, max_capacity: 40, default_duration: 240,
                            menu: 'um monte de comida', event_category: EventCategory.find_by(category: "wedding"),
                            exclusive_address: true, buffet: buffet)
      EventFeature.create!(event: event, feature: Feature.find_by(feature: "alcohol"))
      login_as user, scope: :buffet_owner
      
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

      expect(current_path).to eq event_path(event.id)
      expect(page).to have_content 'Preço especial ajustado'
      expect(page).to have_content 'Preço final de semana e feriados'
      expect(page).to have_content 'Valor base: R$ 5.000,00'
      expect(page).to have_content 'Adicional por pessoa: R$ 130,00'
      expect(page).to have_content 'Adicional por hora: R$ 1.500,00'
    end
    
    it 'with incomplete data' do
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
      BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find_by(method: "credit_card"))
      event = Event.create!(name: 'Eventinho', description: 'um evento muito louco',
                            min_capacity: 20, max_capacity: 40, default_duration: 240,
                            menu: 'um monte de comida', event_category: EventCategory.find_by(category: "wedding"),
                            exclusive_address: true, buffet: buffet)
      EventFeature.create!(event: event, feature: Feature.find_by(feature: "alcohol"))
      login_as user, scope: :buffet_owner
      
      visit root_path
      within 'nav' do
        click_on 'Lista de Eventos'
      end
      click_on 'Eventinho'
      click_on 'Definir preço especial'
      fill_in 'Valor base',	with: '' 
      fill_in 'Adicional por pessoa',	with: '100' 
      fill_in 'Adicional por hora', with: '1000'
      click_on 'Definir Valor'

      expect(page).to have_content 'Erro ao ajustar valor'
      expect(page).to have_content 'Valor base não pode ficar em branco'
    end
  end

end
