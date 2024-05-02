require 'rails_helper'

describe "User view orders" do
  context "#Customer" do
    it "from navbar" do
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
      order = Order.create!(date: "10/10/2024", people_count: 20, details: "Insira detalhes aqui...", event: event, customer: customer)
      login_as customer, scope: :customer

      visit root_path
      within 'nav' do
        click_on 'Meus pedidos'
      end

      expect(page).to have_content 'Seus pedidos'
      expect(page).not_to have_content 'Nenhum pedido realizado'
      expect(page).to have_content "Pedido #{order.code}"
      expect(page).to have_content 'Status: Aguardando avaliação do buffet' 

    end
    
    it "and is empty" do
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
      login_as customer, scope: :customer

      visit root_path
      within 'nav' do
        click_on 'Meus pedidos'
      end
      
      expect(page).to have_content 'Seus pedidos'
      expect(page).to have_content 'Nenhum pedido realizado'
    end
    
    it "and only see owned orders" do
      
    end
    
  end
  
end