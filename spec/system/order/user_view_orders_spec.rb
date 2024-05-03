require 'rails_helper'

describe "User view orders" do
  context "#Customer" do
    it "from navbar" do
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
                          exclusive_address: false, buffet: buffet)
      Event.create!(name: 'Corporativo Galaxy Buffet', description: 'Buffet para eventos corporativo',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'Comida, comida, comida, comida, bebida, bebida', event_category: EventCategory.find_by(category: "corporate"),
                          exclusive_address: true, buffet: buffet)
      customer = Customer.create!(cpf: 33216336557, email: 'r@fael.com', password: 'password' )
      order = Order.create!(date: "10/10/2024", people_count: 20, details: "Insira detalhes aqui...", event: event, customer: customer)
      login_as customer, scope: :customer

      visit root_path
      within 'nav' do
        click_on 'Meus pedidos'
      end

      expect(page).to have_content 'Pedidos em aberto'
      expect(page).not_to have_content 'Nenhum pedido em aberto'
      expect(page).to have_content "Pedido #{order.code}"
      expect(page).to have_content "Evento: Casamento Galaxy Buffet"
      expect(page).to have_content 'Status: Aguardando avaliação do buffet'
      expect(page).to have_content 'Data: 10/10/2024'

    end
    
    it "and is empty" do
      customer = Customer.create!(cpf: 33216336557, email: 'r@fael.com', password: 'password' )
      login_as customer, scope: :customer

      visit root_path
      within 'nav' do
        click_on 'Meus pedidos'
      end
      
      expect(page).to have_content 'Pedidos'
      expect(page).to have_content 'Nenhum pedido em aberto'
    end
    
    it "and only see owned orders" do
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
                          exclusive_address: false, buffet: buffet)
      customer = Customer.create!(cpf: 33216336557, email: 'r@fael.com', password: 'password' )
      customer_1 = Customer.create!(cpf: 52727228090, email: 'ra@fael.com', password: 'password' )
      order = Order.create!(date: "10/10/2024", people_count: 20, details: "Insira detalhes aqui...", event: event, customer: customer)
      order_1 = Order.create!(date: "12/12/2024", people_count: 40, details: "Insira detalhes aqui...", event: event, customer: customer_1)
      login_as customer, scope: :customer

      visit root_path
      within 'nav' do
        click_on 'Meus pedidos'
      end

      expect(page).to have_content 'Pedidos em aberto'
      expect(page).not_to have_content 'Nenhum pedido em aberto'
      expect(page).to have_content "Pedido #{order.code}"
      expect(page).to have_content "Evento: Casamento Galaxy Buffet"
      expect(page).to have_content 'Status: Aguardando avaliação do buffet' 
      expect(page).to have_content 'Data: 10/10/2024'
      expect(page).not_to have_content "Pedido #{order_1.code}"
    end
    
  end
  context "#BuffetOwner" do
    it "from navbar" do
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
                          exclusive_address: false, buffet: buffet)
      customer = Customer.create!(cpf: 33216336557, email: 'r@fael.com', password: 'password' )
      order = Order.create!(date: "10/10/2024", people_count: 20, details: "Insira detalhes aqui...", event: event, customer: customer)
      login_as user, scope: :buffet_owner

      visit root_path
      within 'nav' do
        click_on 'Pedidos'
      end

      expect(page).to have_content 'Pedidos em aberto'
      expect(page).not_to have_content 'Nenhum pedido em aberto'
      expect(page).to have_content "Pedido #{order.code}"
      expect(page).to have_content "Evento: Casamento Galaxy Buffet"
      expect(page).to have_content "Evento: Casamento Galaxy Buffet"
      expect(page).to have_content 'Status: Aguardando avaliação do buffet'
      expect(page).to have_content 'Data: 10/10/2024'

    end

    it "and is empty" do
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

      login_as user, scope: :buffet_owner

      visit root_path
      within 'nav' do
        click_on 'Pedidos'
      end

      expect(page).to have_content 'Pedidos'
      expect(page).to have_content 'Nenhum pedido em aberto'
    end

    it "show waiting orders separated" do
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
                          exclusive_address: false, buffet: buffet)
      customer = Customer.create!(cpf: 33216336557, email: 'r@fael.com', password: 'password' )
      customer_1 = Customer.create!(cpf: 52727228090, email: 'ra@fael.com', password: 'password' )
      order = Order.create!(date: "10/10/2024", people_count: 20, details: "Insira detalhes aqui...", event: event, customer: customer)
      order_1 = Order.create!(date: "12/12/2024", people_count: 40, details: "Insira detalhes aqui...", event: event, customer: customer_1, status: 2)
      login_as user, scope: :buffet_owner

      visit root_path
      within 'nav' do
        click_on 'Pedidos'
      end

      expect(page).not_to have_content 'Nenhum pedido em aberto'
      expect(page).to have_content 'Pedidos em aberto'
      expect(page).to have_content "Pedido #{order.code}"
      expect(page).to have_content 'Pedidos fechados'
      expect(page).to have_content "Pedido #{order_1.code}"
      
    end
    
  end
end
