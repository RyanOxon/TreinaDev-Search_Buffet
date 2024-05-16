require 'rails_helper'

describe "User edit order proposal" do
  context "#buffet_owner" do
    it "from order details" do
      load_categories
      load_payments
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '66693953000190', phone_number: '99123456789', 
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
      order = Order.create!(date: 1.year.from_now , people_count: 20, details: "Insira detalhes aqui...", event: event, customer: customer, status: "negotiating")
      proposal = ServiceProposal.create!(value: 2000, extra_fee: 100, discount: 200, 
                              description: "100 reais de frete e 10% de desconto no dinheiro", 
                              payment_method_id: PaymentMethod.find_by(method: "cash").id,
                              order: order, expiration_date: 1.month.from_now)
      login_as user, scope: :buffet_owner

      visit root_path
      within 'nav' do
        click_on 'Pedidos'
      end
      click_on "#{order.code}"

      expect(page).to have_checked_field "Valor especial: R$ 2.000,00"
      expect(page).to have_select 'Metodo de pagamento', selected: 'Dinheiro'
      expect(page).to have_field 'Taxa extra', with: '100'
      expect(page).to have_field 'Desconto', with: '200'
      expect(page).to have_field 'Descrição', with: "100 reais de frete e 10% de desconto no dinheiro"
      expect(page).to have_field 'Valido até', with: proposal.expiration_date
      expect(page).to have_button 'Atualizar Proposta de serviço'

    end

    it "and cannot edit if confirmed" do
      load_categories
      load_payments
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '66693953000190', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      event = Event.create!(name: 'Eventinho', description: 'um evento muito louco',
                            min_capacity: 20, max_capacity: 50, default_duration: 240,
                            menu: 'um monte de comida', event_category: EventCategory.find_by(category: "wedding"),
                            exclusive_address: true, buffet: buffet)
      EventPrice.create!(price_type: 0, base_value: 2000, extra_per_person: 120, extra_per_hour: 500, event: event)
      customer = Customer.create!(cpf: 33216336557, email: 'r@fael.com', password: 'password' )
      order = Order.create!(date: 1.year.from_now , people_count: 25, details: "Insira detalhes aqui...", event: event, customer: customer, status: "confirmed")
      ServiceProposal.create!(value: 2000, extra_fee: 100, discount: 200, 
                              description: "100 reais de frete e 10% de desconto no dinheiro", 
                              payment_method_id: PaymentMethod.find_by(method: "cash").id,
                              order: order, expiration_date: 1.month.from_now, status: "confirmed")
      login_as user, scope: :buffet_owner

      visit root_path
      within 'nav' do
        click_on 'Pedidos'
      end
      click_on "#{order.code}"

      expect(page).to have_content "Status do pedido: Pedido confirmado"
      expect(page).to have_content "Status: Proposta aceita"
      expect(page).not_to have_content "Valor estimado"
      expect(page).not_to have_field "Valor padrão: 2600"
      expect(page).not_to have_field "Valor especial: não registrado", disabled: true
      expect(page).not_to have_field "Metodo de pagamento"
      expect(page).not_to have_field "Taxa extra"
      expect(page).not_to have_field "Desconto"
      expect(page).not_to have_field "Descrição"
      expect(page).not_to have_field "Valido até"
      expect(page).not_to have_button "Atualizar Proposta de serviço"
                            

    end

    it "and cannot edit if canceled" do
      load_categories
      load_payments
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '66693953000190', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      event = Event.create!(name: 'Eventinho', description: 'um evento muito louco',
                            min_capacity: 20, max_capacity: 50, default_duration: 240,
                            menu: 'um monte de comida', event_category: EventCategory.find_by(category: "wedding"),
                            exclusive_address: true, buffet: buffet)
      EventPrice.create!(price_type: 0, base_value: 2000, extra_per_person: 120, extra_per_hour: 500, event: event)
      customer = Customer.create!(cpf: 33216336557, email: 'r@fael.com', password: 'password' )
      order = Order.create!(date: 1.year.from_now , people_count: 25, details: "Insira detalhes aqui...", event: event, customer: customer, status: "canceled")
      ServiceProposal.create!(value: 2000, extra_fee: 100, discount: 200, 
                              description: "100 reais de frete e 10% de desconto no dinheiro", 
                              payment_method_id: PaymentMethod.find_by(method: "cash").id,
                              order: order, expiration_date: 1.month.from_now, status: "canceled")
      login_as user, scope: :buffet_owner

      visit root_path
      within 'nav' do
        click_on 'Pedidos'
      end
      click_on "#{order.code}"

      expect(page).to have_content "Status do pedido: Pedido cancelado"
      expect(page).to have_content "Status: Proposta cancelada"
      expect(page).not_to have_content "Valor estimado"
      expect(page).not_to have_field "Valor padrão: 2600"
      expect(page).not_to have_field "Valor especial: não registrado", disabled: true
      expect(page).not_to have_field "Metodo de pagamento"
      expect(page).not_to have_field "Taxa extra"
      expect(page).not_to have_field "Desconto"
      expect(page).not_to have_field "Descrição"
      expect(page).not_to have_field "Valido até"
      expect(page).not_to have_button "Atualizar Proposta de serviço"
                            

    end
    
    it "sucessfully" do
      load_categories
      load_payments
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '66693953000190', phone_number: '99123456789', 
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
      order = Order.create!(date: 1.year.from_now , people_count: 20, details: "Insira detalhes aqui...", event: event, customer: customer, status: "negotiating")
      ServiceProposal.create!(value: 2000, extra_fee: 100, discount: 200, 
                              description: "100 reais de frete e 10% de desconto no dinheiro", 
                              payment_method_id: PaymentMethod.find_by(method: "cash").id,
                              order: order, expiration_date: 1.month.from_now)
      login_as user, scope: :buffet_owner

      visit root_path
      within 'nav' do
        click_on 'Pedidos'
      end
      click_on "#{order.code}"
      fill_in "Taxa extra",	with: "10" 
      click_on 'Atualizar Proposta de serviço'

      expect(page).to have_content 'Proposta atualizada, aguardando confirmação do cliente'
      expect(page).to have_content "Status do pedido: Proposta em negociação"
      expect(page).to have_content "Taxa extra: R$ 10,00"

    end
    
    it "with missing params" do
      load_categories
      load_payments
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '66693953000190', phone_number: '99123456789', 
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
      order = Order.create!(date: 1.year.from_now , people_count: 20, details: "Insira detalhes aqui...", event: event, customer: customer, status: "negotiating")
      ServiceProposal.create!(value: 2000, extra_fee: 100, discount: 200, 
                              description: "100 reais de frete e 10% de desconto no dinheiro", 
                              payment_method_id: PaymentMethod.find_by(method: "cash").id,
                              order: order, expiration_date: 1.month.from_now)
      login_as user, scope: :buffet_owner

      visit root_path
      within 'nav' do
        click_on 'Pedidos'
      end
      click_on "#{order.code}"
      fill_in "Valido até",	with: "" 
      click_on 'Atualizar Proposta de serviço'

      expect(page).to have_content "Erro ao atualizar"
      expect(page).to have_content "Valido até não pode ficar em branco"

    end
  end
  
  
end
