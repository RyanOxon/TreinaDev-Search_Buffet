require 'rails_helper'

describe "User orders a event" do
  context "#customer" do
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
      EventPrice.create!(price_type: 0, base_value: 20000, extra_per_person: 140, extra_per_hour: 4000, event: event_3)
      customer = Customer.create!(cpf: 33216336557, email: 'r@fael.com', password: 'password' )
      login_as customer, scope: :customer

      visit root_path
      click_on 'Galaxy Buffet'
      click_on 'Casamento Galaxy Buffet'
      click_on 'Criar um pedido'

      expect(page).to have_content "Fazer um pedido para o evento: Casamento Galaxy Buffet"
      expect(page).to have_field "Numero de pessoas"
      expect(page).to have_field "Data"
      expect(page).to have_field "Detalhes"
      expect(page).to have_button "Enviar Pedido"

    end

    it "sucessfully with exclusive address" do
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
      EventPrice.create!(price_type: 0, base_value: 20000, extra_per_person: 140, extra_per_hour: 4000, event: event_3)
      customer = Customer.create!(cpf: 33216336557, email: 'r@fael.com', password: 'password' )
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC12345')
      login_as customer, scope: :customer

      visit root_path
      click_on 'Galaxy Buffet'
      click_on 'Casamento Galaxy Buffet'
      click_on 'Criar um pedido'
      fill_in "Numero de pessoas",	with: "20"
      fill_in "Data",	with: "09/09/2024"
      fill_in "Detalhes",	with: "Insira detalhes aqui..." 
      click_on "Enviar Pedido"

      expect(page).to have_content 'Pedido enviado com sucesso'
      expect(page).to have_content "Pedido: ABC12345"
      expect(page).to have_content 'Status do pedido: Aguardando avaliação do buffet'
      expect(page).to have_content 'Evento para 20 pessoas'
      expect(page).to have_content 'Na data: 09/09/2024'
      expect(page).to have_content 'Endereço: Rua Estrelas, 123'
      expect(page).to have_content 'Insira detalhes aqui...'
      expect(page).to have_link "Voltar para Casamento Galaxy Buffet"
      expect(page).to have_link "Voltar para Galaxy Buffet"
    end

    it "sucessfully without exclusive address" do
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
                          exclusive_address: false, buffet: buffet)
      EventFeature.create!(event: event, feature: Feature.find(1))
      event_3 = Event.create!(name: 'Corporativo Galaxy Buffet', description: 'Buffet para eventos corporativo',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'Comida, comida, comida, comida, bebida, bebida', event_category: EventCategory.find(5),
                          exclusive_address: true, buffet: buffet)
      EventFeature.create!(event: event_3, feature: Feature.find(3))
      EventPrice.create!(price_type: 0, base_value: 10000, extra_per_person: 100, extra_per_hour: 2000, event: event)
      EventPrice.create!(price_type: 0, base_value: 20000, extra_per_person: 140, extra_per_hour: 4000, event: event_3)
      customer = Customer.create!(cpf: 33216336557, email: 'r@fael.com', password: 'password' )
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC12345')
      login_as customer, scope: :customer

      visit root_path
      click_on 'Galaxy Buffet'
      click_on 'Casamento Galaxy Buffet'
      click_on 'Criar um pedido'
      fill_in "Numero de pessoas",	with: "20"
      fill_in "Data",	with: "09/09/2024"
      fill_in "Detalhes",	with: "Insira detalhes aqui..."
      fill_in "Endereço", with: "Rua das bolinhas, 123"
      click_on "Enviar Pedido"

      expect(page).to have_content 'Pedido enviado com sucesso'
      expect(page).to have_content "Pedido: ABC12345"
      expect(page).to have_content 'Status do pedido: Aguardando avaliação do buffet'
      expect(page).to have_content 'Evento para 20 pessoas'
      expect(page).to have_content 'Na data: 09/09/2024'
      expect(page).to have_content 'Endereço: Rua das bolinhas, 123'
      expect(page).to have_content 'Insira detalhes aqui...'
      expect(page).to have_link "Voltar para Casamento Galaxy Buffet"
      expect(page).to have_link "Voltar para Galaxy Buffet"
    end

    xit "with incomplete data" do
      
    end

    xit "with more people than max capacity" do
      
    end

    xit "with less people than min capacity" do
      
    end
    
    xit "with expired date" do
      
    end
    
  end
end
