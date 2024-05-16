require 'rails_helper'

describe "User orders a event" do
  context "#customer" do
    it "only if authenticated" do
      load_categories
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '321.543.12/0001-33', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      event = Event.create!(name: 'Casamento Galaxy Buffet', description: 'um casamento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find_by(category: "wedding"),
                          exclusive_address: true, buffet: buffet)

      visit new_event_order_path(event.id)

      expect(current_path).to eq new_customer_session_path 
      
    end

    it "from event details" do
      load_categories
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '321.543.12/0001-33', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      Event.create!(name: 'Casamento Galaxy Buffet', description: 'um casamento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find_by(category: "wedding"),
                          exclusive_address: true, buffet: buffet)
      Event.create!(name: 'Corporativo Galaxy Buffet', description: 'Buffet para eventos corporativo',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'Comida, comida, comida, comida, bebida, bebida', event_category: EventCategory.find_by(category: "corporate"),
                          exclusive_address: true, buffet: buffet)
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
      load_categories
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '321.543.12/0001-33', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      Event.create!(name: 'Casamento Galaxy Buffet', description: 'um casamento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find_by(category: "wedding"),
                          exclusive_address: true, buffet: buffet)
      Event.create!(name: 'Corporativo Galaxy Buffet', description: 'Buffet para eventos corporativo',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'Comida, comida, comida, comida, bebida, bebida', event_category: EventCategory.find_by(category: "corporate"),
                          exclusive_address: true, buffet: buffet)
      customer = Customer.create!(cpf: 33216336557, email: 'r@fael.com', password: 'password' )
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC12345')
      login_as customer, scope: :customer

      visit root_path
      click_on 'Galaxy Buffet'
      click_on 'Casamento Galaxy Buffet'
      click_on 'Criar um pedido'
      fill_in "Numero de pessoas",	with: "20"
      fill_in "Data",	with: "#{1.year.from_now}"
      fill_in "Detalhes",	with: "Insira detalhes aqui..." 
      click_on "Enviar Pedido"

      expect(page).to have_content 'Pedido enviado com sucesso'
      expect(page).to have_content "Pedido: ABC12345"
      expect(page).to have_content 'Status do pedido: Aguardando avaliação do buffet'
      expect(page).to have_content 'Evento para 20 pessoas'
      expect(page).to have_content "Na data: #{I18n.localize(Order.last.date)}"
      expect(page).to have_content 'Endereço: Rua Estrelas, 123'
      expect(page).to have_content 'Insira detalhes aqui...'
      expect(page).to have_link "Voltar para Casamento Galaxy Buffet"
      expect(page).to have_link "Voltar para Galaxy Buffet"
    end

    it "sucessfully without exclusive address" do
      load_categories
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '321.543.12/0001-33', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      Event.create!(name: 'Casamento Galaxy Buffet', description: 'um casamento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find_by(category: "wedding"),
                          exclusive_address: false, buffet: buffet)
      Event.create!(name: 'Corporativo Galaxy Buffet', description: 'Buffet para eventos corporativo',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'Comida, comida, comida, comida, bebida, bebida', event_category: EventCategory.find_by(category: "corporate"),
                          exclusive_address: true, buffet: buffet)
      customer = Customer.create!(cpf: 33216336557, email: 'r@fael.com', password: 'password' )
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC12345')
      login_as customer, scope: :customer

      visit root_path
      click_on 'Galaxy Buffet'
      click_on 'Casamento Galaxy Buffet'
      click_on 'Criar um pedido'
      fill_in "Numero de pessoas",	with: "20"
      fill_in "Data",	with: "#{1.year.from_now}"
      fill_in "Detalhes",	with: "Insira detalhes aqui..."
      fill_in "Endereço", with: "Rua das bolinhas, 123"
      click_on "Enviar Pedido"

      expect(page).to have_content 'Pedido enviado com sucesso'
      expect(page).to have_content "Pedido: ABC12345"
      expect(page).to have_content 'Status do pedido: Aguardando avaliação do buffet'
      expect(page).to have_content 'Evento para 20 pessoas'
      expect(page).to have_content "Na data: #{I18n.localize(Order.last.date)}"
      expect(page).to have_content 'Endereço: Rua das bolinhas, 123'
      expect(page).to have_content 'Insira detalhes aqui...'
      expect(page).to have_link "Voltar para Casamento Galaxy Buffet"
      expect(page).to have_link "Voltar para Galaxy Buffet"
    end

    it "with incomplete data" do
      load_categories
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '321.543.12/0001-33', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      Event.create!(name: 'Casamento Galaxy Buffet', description: 'um casamento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find_by(category: "wedding"),
                          exclusive_address: true, buffet: buffet)
      Event.create!(name: 'Corporativo Galaxy Buffet', description: 'Buffet para eventos corporativo',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'Comida, comida, comida, comida, bebida, bebida', event_category: EventCategory.find_by(category: "corporate"),
                          exclusive_address: true, buffet: buffet)
      customer = Customer.create!(cpf: 33216336557, email: 'r@fael.com', password: 'password' )
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC12345')
      login_as customer, scope: :customer

      visit root_path
      click_on 'Galaxy Buffet'
      click_on 'Casamento Galaxy Buffet'
      click_on 'Criar um pedido'
      fill_in "Numero de pessoas",	with: ""
      fill_in "Data",	with: ""
      fill_in "Detalhes",	with: "Insira detalhes aqui..."
      click_on "Enviar Pedido"

      expect(page).to have_content 'Erro ao criar pedido'
      expect(page).to have_content 'Numero de pessoas não pode ficar em branco'
      expect(page).to have_content 'Data não pode ficar em branco'

      
    end

    it "with more people than max capacity" do
      load_categories
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '321.543.12/0001-33', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      Event.create!(name: 'Casamento Galaxy Buffet', description: 'um casamento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find_by(category: "wedding"),
                          exclusive_address: true, buffet: buffet)
      Event.create!(name: 'Corporativo Galaxy Buffet', description: 'Buffet para eventos corporativo',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'Comida, comida, comida, comida, bebida, bebida', event_category: EventCategory.find_by(category: "corporate"),
                          exclusive_address: true, buffet: buffet)
      customer = Customer.create!(cpf: 33216336557, email: 'r@fael.com', password: 'password' )
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC12345')
      login_as customer, scope: :customer

      visit root_path
      click_on 'Galaxy Buffet'
      click_on 'Casamento Galaxy Buffet'
      click_on 'Criar um pedido'
      fill_in "Numero de pessoas",	with: "45"
      fill_in "Data",	with: "#{1.year.from_now}"
      fill_in "Detalhes",	with: "Insira detalhes aqui..."
      click_on "Enviar Pedido"

      expect(page).to have_content 'Erro ao criar pedido'
      expect(page).to have_content 'Numero de pessoas não pode exceder capacidade do evento'
      
    end
    
    it "with expired date" do
      load_categories
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '321.543.12/0001-33', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      Event.create!(name: 'Casamento Galaxy Buffet', description: 'um casamento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find_by(category: "wedding"),
                          exclusive_address: false, buffet: buffet)
      Event.create!(name: 'Corporativo Galaxy Buffet', description: 'Buffet para eventos corporativo',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'Comida, comida, comida, comida, bebida, bebida', event_category: EventCategory.find_by(category: "corporate"),
                          exclusive_address: true, buffet: buffet)
      customer = Customer.create!(cpf: 33216336557, email: 'r@fael.com', password: 'password' )
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC12345')
      login_as customer, scope: :customer

      visit root_path
      click_on 'Galaxy Buffet'
      click_on 'Casamento Galaxy Buffet'
      click_on 'Criar um pedido'
      fill_in "Numero de pessoas",	with: "20"
      fill_in "Data",	with: "#{1.year.ago}"
      fill_in "Detalhes",	with: "Insira detalhes aqui..."
      fill_in "Endereço", with: "Rua das bolinhas, 123"
      click_on "Enviar Pedido"

      expect(page).to have_content "Erro ao criar pedido"
      expect(page).to have_content "Data deve ser futura"
      
    end

    it "became cancelled after 20 days without proposal" do
      load_categories
      load_payments
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '321.543.12/0001-33', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find_by(method: "cash"))
      event = Event.create!(name: 'Eventinho', description: 'um evento muito louco',
                            min_capacity: 20, max_capacity: 50, default_duration: 240,
                            menu: 'um monte de comida', event_category: EventCategory.find_by(category: "wedding"),
                            exclusive_address: true, buffet: buffet)
      EventPrice.create!(price_type: 1, base_value: 2000, extra_per_person: 120, extra_per_hour: 500, event: event)
      customer = Customer.create!(cpf: 33216336557, email: 'r@fael.com', password: 'password' )
      order = Order.create!(date: 1.year.from_now , people_count: 20, details: "Insira detalhes aqui...", event: event, customer: customer)
      
      login_as customer, scope: :customer

      travel 21.days
      visit root_path
      within 'nav' do
        click_on 'Meus pedidos'
      end
      click_on "#{order.code}"

      expect(page).to have_content "Pedido cancelado por inatividade do buffet"
      expect(page).to have_content "Status do pedido: Pedido cancelado"

    end
    
  end
end
