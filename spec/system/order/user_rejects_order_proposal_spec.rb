require 'rails_helper'

describe "User rejects order proposal" do
  context "#Customer" do
    it "and keep negotiating" do
      load_payments
      load_categories
      buffet_owner = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      customer = Customer.create!(cpf: 33216336557, email: 'r@fael.com', password: 'password' )
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '321.543.12/0001-33', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: buffet_owner)
      BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find_by(method: "cash"))
      event = Event.create!(name: 'Eventinho', description: 'um evento muito louco',
                            min_capacity: 20, max_capacity: 50, default_duration: 240,
                            menu: 'um monte de comida', event_category: EventCategory.find_by(category: "wedding"),
                            exclusive_address: true, buffet: buffet)
      EventPrice.create!(price_type: 0, base_value: 2000, extra_per_person: 120, extra_per_hour: 500, event: event)
      order = Order.create!(date: 1.year.from_now , people_count: 25, details: "Insira detalhes aqui...", 
                            event: event, customer: customer, status: "negotiating" )
      ServiceProposal.create!(value: 2000, extra_fee: 100, discount: 200, 
                              description: "100 reais de frete e 10% de desconto no dinheiro", 
                              payment_method_id: PaymentMethod.find_by(method: "cash").id,
                              order: order, expiration_date: 1.month.from_now, status: "waiting")
      login_as customer, scope: :customer

      visit root_path
      within 'nav' do
        click_on 'Meus pedidos'
      end
      click_on "#{order.code}"
      click_on "Recusar proposta"

      expect(page).to have_content "Proposta recusada, aguardando nova proposta"
      expect(page).to have_content "Status do pedido: Proposta em negociação"
      expect(page).to have_content "Status: Rejeitado, Aguardando nova proposta"


    end

    it "and cancel order" do
      load_payments
      load_categories
      buffet_owner = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      customer = Customer.create!(cpf: 33216336557, email: 'r@fael.com', password: 'password' )
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '321.543.12/0001-33', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: buffet_owner)
      BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find_by(method: "cash"))
      event = Event.create!(name: 'Eventinho', description: 'um evento muito louco',
                            min_capacity: 20, max_capacity: 50, default_duration: 240,
                            menu: 'um monte de comida', event_category: EventCategory.find_by(category: "wedding"),
                            exclusive_address: true, buffet: buffet)
      EventPrice.create!(price_type: 0, base_value: 2000, extra_per_person: 120, extra_per_hour: 500, event: event)
      order = Order.create!(date: 1.year.from_now , people_count: 25, details: "Insira detalhes aqui...", 
                            event: event, customer: customer, status: "negotiating" )
      ServiceProposal.create!(value: 2000, extra_fee: 100, discount: 200, 
                              description: "100 reais de frete e 10% de desconto no dinheiro", 
                              payment_method_id: PaymentMethod.find_by(method: "cash").id,
                              order: order, expiration_date: 1.month.from_now, status: "waiting")
      login_as customer, scope: :customer

      visit root_path
      within 'nav' do
        click_on 'Meus pedidos'
      end
      click_on "#{order.code}"
      click_on "Cancelar pedido"

      expect(page).to have_content "Proposta cancelada, negociação encerrada"
      expect(page).to have_content "Status do pedido: Pedido cancelado"
      expect(page).to have_content "Status: Proposta cancelada"


    end
    
    xit "only if authorized" do
      
    end

  end
  
  
end
