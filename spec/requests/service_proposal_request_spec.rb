require 'rails_helper'

describe "requests for service_proposal" do
  context "#update" do
    it "and its not authorized" do
      load_categories
      load_payments
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      user_2 = BuffetOwner.create!(email: 'r@fael.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '20757307000149', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find_by(method: "cash"))
      Buffet.create!(brand_name: 'Volcano Buffets', corporate_name: 'Geological fissure LTDA', 
                              registration: '12742045000110', phone_number: '99123456789', 
                              email: 'atendimento@lava.com', address: 'Rua explosion, 123',
                              district: 'underground', city: 'Tectonic rift', state_code: 'TT', 
                              zip_code: '99999-999', description: 'A blast of buffet', 
                              buffet_owner: user_2)
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
      login_as user_2, scope: :buffet_owner

      patch order_service_proposal_path(order.id, proposal.id), params: {service_proposal: {value: 123123}}

      expect(response).to redirect_to user_2.buffet
    end
    
  end
  
end
