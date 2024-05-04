require 'rails_helper'

describe "User approves order" do
  context "#buffet owner" do
    it "from order detail" do
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
      EventFeature.create!(event: event, feature: Feature.find_by(feature: "alcohol"))
      EventFeature.create!(event: event, feature: Feature.find_by(feature: "decoration"))
      EventPrice.create!(price_type: 0, base_value: 2000, extra_per_person: 120, extra_per_hour: 500, event: event)
      customer = Customer.create!(cpf: 33216336557, email: 'r@fael.com', password: 'password' )
      order = Order.create!(date: 1.year.from_now , people_count: 25, details: "Insira detalhes aqui...", event: event, customer: customer)
      login_as user, scope: :buffet_owner

      visit root_path
      within 'nav' do
        click_on 'Pedidos'
      end
      click_on "#{order.code}"

      expect(page).to have_content "Valor estimado"
      expect(page).to have_field "Valor padrão: 2600"
      expect(page).to have_field "Valor especial: não registrado", disabled: true
      expect(page).to have_field "Metodo de pagamento"
      expect(page).to have_field "Taxa extra"
      expect(page).to have_field "Desconto"
      expect(page).to have_field "Descrição"
      expect(page).to have_field "Valido até"
      expect(page).to have_button "Criar Proposta de serviço"
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
      BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find_by(method: "cash"))
      event = Event.create!(name: 'Eventinho', description: 'um evento muito louco',
                            min_capacity: 20, max_capacity: 50, default_duration: 240,
                            menu: 'um monte de comida', event_category: EventCategory.find_by(category: "wedding"),
                            exclusive_address: true, buffet: buffet)
      EventFeature.create!(event: event, feature: Feature.find_by(feature: "alcohol"))
      EventFeature.create!(event: event, feature: Feature.find_by(feature: "decoration"))
      EventPrice.create!(price_type: 0, base_value: 2000, extra_per_person: 120, extra_per_hour: 500, event: event)
      EventPrice.create!(price_type: 1, base_value: 2500, extra_per_person: 160, extra_per_hour: 700, event: event)
      customer = Customer.create!(cpf: 33216336557, email: 'r@fael.com', password: 'password' )
      order = Order.create!(date: 1.year.from_now , people_count: 20, details: "Insira detalhes aqui...", event: event, customer: customer)
      login_as user, scope: :buffet_owner

      visit root_path
      within 'nav' do
        click_on 'Pedidos'
      end
      click_on "#{order.code}"

      choose "Valor especial: 2500"
      select "Dinheiro", from: "Metodo de pagamento"
      fill_in "Taxa extra",	with: "0"
      fill_in "Desconto",	with: "250"
      fill_in "Descrição",	with: "10% de desconto a vista"
      fill_in "Valido até",	with: "#{1.month.from_now}" 
      click_on "Criar Proposta de serviço"

      expect(current_path).to eq order_path(order.id)
      expect(page).to have_content "Proposta enviada, aguardando confirmação do cliente" 
      expect(page).to have_content "Proposta atual"
      expect(page).to have_content "Valor: #{ServiceProposal.last.get_real_value}"
      expect(page).to have_content "Taxa extra: 0"
      expect(page).to have_content "Desconto: 250"
      expect(page).to have_content "Motivo: 10% de desconto a vista"
      expect(page).to have_content "Proposta valida até: #{I18n.localize(ServiceProposal.last.expiration_date)}"
      expect(page).to have_content "Status: Aguardando confirmação do cliente"
      
    end
    
    
  end
  
end