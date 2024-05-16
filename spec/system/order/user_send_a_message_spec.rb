require 'rails_helper'

describe "user send a message on order chat" do
  context "#buffetOwner" do
    it 'from order details' do
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
      login_as user, scope: :buffet_owner

      visit root_path
      within 'nav' do
        click_on 'Pedidos'
      end
      click_on "#{order.code}"

      expect(page).to have_content "Chat do pedido #{order.code}"
      expect(page).to have_field('message[content]')
      expect(page).to have_button 'Enviar Mensagem'

    end    
    it "sucessfully" do
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
      login_as user, scope: :buffet_owner

      visit root_path
      within 'nav' do
        click_on 'Pedidos'
      end
      click_on "#{order.code}"

      fill_in "message[content]",	with: "Olá, tudo bem?"
      click_on 'Enviar'

      expect(page).to have_content "Chat do pedido #{order.code}"
      expect(page).to have_content "Mensagem enviada com sucesso!"
      expect(page).to have_content "Galaxy Buffet" 
      expect(page).to have_content "Olá, tudo bem?"
      expect(page).to have_content "#{I18n.localize(Message.last.posted_at, format: :short)}"
      expect(page).to have_field('message[content]')
      expect(page).to have_button 'Enviar Mensagem'
      
    end

    it "and see his message with older messages" do
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
      message = Message.create!(content: "Olá, gostaria de um desconto no dinheiro", posted_at: 2.days.ago, order: order, user: customer)
      login_as user, scope: :buffet_owner

      visit root_path
      within 'nav' do
        click_on 'Pedidos'
      end
      click_on "#{order.code}"

      fill_in "message[content]",	with: "10% de desconto é o maximo que consigo oferecer"
      click_on 'Enviar'

      expect(page).to have_content "Chat do pedido #{order.code}"
      expect(page).to have_content "Mensagem enviada com sucesso!"
      expect(page).to have_content "r@fael.com" 
      expect(page).to have_content "Olá, gostaria de um desconto no dinheiro"
      expect(page).to have_content "#{I18n.localize(message.posted_at, format: :short)}"
      expect(page).to have_content "Galaxy Buffet" 
      expect(page).to have_content "10% de desconto é o maximo que consigo oferecer"
      expect(page).to have_content "#{I18n.localize(Message.last.posted_at, format: :short)}"
      expect(page).to have_field('message[content]')
      expect(page).to have_button 'Enviar Mensagem'
      
    end
    
  end
  context "#customer" do
    it "from order details" do
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
      login_as customer, scope: :customer

      visit root_path
      within 'nav' do
        click_on 'Meus pedidos'
      end
      click_on "#{order.code}"

      expect(page).to have_content "Chat do pedido #{order.code}"
      expect(page).to have_field('message[content]')
      expect(page).to have_button 'Enviar Mensagem'
      
    end
    it "sucessfully" do
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
      login_as customer, scope: :customer

      visit root_path
      within 'nav' do
        click_on 'Meus pedidos'
      end
      click_on "#{order.code}"

      fill_in "message[content]",	with: "Olá, tudo bem?"
      click_on 'Enviar'

      expect(page).to have_content "Chat do pedido #{order.code}"
      expect(page).to have_content "Mensagem enviada com sucesso!"
      expect(page).to have_content "r@fael.com" 
      expect(page).to have_content "Olá, tudo bem?"
      expect(page).to have_content "#{I18n.localize(Message.last.posted_at, format: :short)}"
      expect(page).to have_field('message[content]')
      expect(page).to have_button 'Enviar Mensagem'
    end
  end
  it "with no text" do
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
    login_as user, scope: :buffet_owner

    visit root_path
    within 'nav' do
      click_on 'Pedidos'
    end
    click_on "#{order.code}"

    fill_in "message[content]",	with: ""
    click_on 'Enviar'

    expect(page).to have_content "Chat do pedido #{order.code}"
    expect(page).to have_content "Erro ao enviar mensagem"
  end

  it "must be authenticated" do
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
    expect(page).to have_content "Acesso não autorizado"
  end
end
