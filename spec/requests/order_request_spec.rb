require 'rails_helper'

describe "requests for order" do
  context "#index" do
    it "must be authenticated" do
      get orders_path

      expect(response).to redirect_to root_path
    end
  end
  context "#messages" do
    it "must be authenticated" do
      load_categories
      user = BuffetOwner.create!(email: 'raf@el.com', password: 'password')
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
      customer = Customer.create!(cpf: 33216336557, email: 'r@fael.com', password: 'password' )
      order = Order.create!(date: 1.year.from_now , people_count: 25, details: "Insira detalhes aqui...", event: event, customer: customer)


      post order_messages_path(order.id), params: {message: {content: 'Olá, gostaria de saber mais sobre o cardápio'}}

      expect(response).to redirect_to root_path 
    end
    
  end
end
