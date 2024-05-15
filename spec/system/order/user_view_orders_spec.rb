require 'rails_helper'

describe "User view orders" do
  it "only if authenticated" do
    load_categories
    load_payments
    load_features
    user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
    buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                            registration: '321.543.12/0001-33', phone_number: '99123456789', 
                            email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                            district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                            zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                            buffet_owner: user)
    BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find_by(method: "credit_card"))
    BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find_by(method: "debit_card"))
    event = Event.create!(name: 'Eventinho', description: 'um evento muito louco',
                          min_capacity: 20, max_capacity: 50, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find_by(category: "wedding"),
                          exclusive_address: true, buffet: buffet)
    EventPrice.create!(price_type: 0, base_value: 2000, extra_per_person: 120, extra_per_hour: 500, event: event)
    customer = Customer.create!(cpf: 33216336557, email: 'r@fael.com', password: 'password' )
    order = Order.create!(date: 1.year.from_now , people_count: 25, details: "Insira detalhes aqui...", event: event, customer: customer)

    visit order_path(order)

    expect(current_path).not_to eq order_path(order)

  end

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

    it "only if authorized" do
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
      login_as customer_1, scope: :customer
    
      visit order_path(order)

      expect(current_path).not_to eq order_path(order)
      expect(page).to have_content "Acesso não autorizado"
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
      order = Order.create!(date: 1.year.from_now, people_count: 20, details: "Insira detalhes aqui...", event: event, customer: customer)
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
      expect(page).to have_content "Data: #{I18n.localize(Order.last.date)}"

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

    it "show waiting orders as open orders and comfirmed as closed" do
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
      order = Order.create!(date: 1.year.from_now, people_count: 20, details: "Insira detalhes aqui...", event: event, customer: customer)
      order_1 = Order.create!(date: 6.months.from_now, people_count: 40, details: "Insira detalhes aqui...", event: event, customer: customer_1, status: 'confirmed')
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

    it "show negotiating orders as open orders and canceled as close" do
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
      order = Order.create!(date: 1.year.from_now, people_count: 20, details: "Insira detalhes aqui...", event: event, customer: customer, status: 'negotiating')
      order_1 = Order.create!(date: 6.months.from_now, people_count: 40, details: "Insira detalhes aqui...", event: event, customer: customer_1, status: 'canceled')
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

    it "only if authorized" do
      load_categories
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      user_2 = BuffetOwner.create!(email: 'r@fael.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '321.543.12/0001-33', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      Buffet.create!(brand_name: 'Volcano Buffets', corporate_name: 'Geological fissure LTDA', 
                    registration: '321.543.12/0001-32', phone_number: '99123456789', 
                    email: 'atendimento@lava.com', address: 'Rua explosion, 123',
                    district: 'underground', city: 'Tectonic rift', state_code: 'TT', 
                    zip_code: '99999-999', description: 'A blast of buffet', 
                    buffet_owner: user_2)
      event = Event.create!(name: 'Casamento Galaxy Buffet', description: 'um casamento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find_by(category: "wedding"),
                          exclusive_address: false, buffet: buffet)
      customer = Customer.create!(cpf: 33216336557, email: 'r@fael.com', password: 'password' )
      order = Order.create!(date: "10/10/2024", people_count: 20, details: "Insira detalhes aqui...", event: event, customer: customer)
      login_as user_2, scope: :buffet_owner
    
      visit order_path(order)

      expect(current_path).not_to eq order_path(order)
      expect(page).to have_content "Acesso não autorizado"
    end
    
  end
end
