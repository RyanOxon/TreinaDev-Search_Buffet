require 'rails_helper'

describe "user view order details" do
  context "#BuffetOwner" do
    it "from orders list" do
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
      click_on "#{order.code}"

      expect(page).not_to have_content "Existem outros pedidos na mesma data! Verifique"
      expect(page).to have_content "Pedido: #{order.code}"
      expect(page).to have_content 'Status do pedido: Aguardando avaliação do buffet'
      expect(page).to have_content 'Evento para 20 pessoas'
      expect(page).to have_content 'Na data: 10/10/2024'
      expect(page).to have_content 'Endereço: Rua Estrelas, 123'
      expect(page).to have_content 'Insira detalhes aqui...'
      expect(page).to have_link "Voltar para Casamento Galaxy Buffet"
      expect(page).to have_link "Voltar para Galaxy Buffet"

    end

    it "and receive have 2 order to the same date" do
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
      customer_1 = Customer.create!(cpf: 72646805098, email: 'raf@el.com', password: 'password' )
      order = Order.create!(date: "10/10/2024", people_count: 20, details: "Insira detalhes aqui...", event: event, customer: customer)
      Order.create!(date: "10/10/2024", people_count: 40, details: "Insira detalhes aqui...", event: event, customer: customer_1)
      
      login_as user, scope: :buffet_owner

      visit root_path
      within 'nav' do
        click_on 'Pedidos'
      end
      click_on "#{order.code}"

      expect(page).to have_content "Existem outros pedidos na mesma data! Verifique"
      
    end
    
  end
end