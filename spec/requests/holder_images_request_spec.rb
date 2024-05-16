require 'rails_helper'

describe "requests for holder_images" do
  context "#event/create" do
    it "must be authenticated" do
      load_categories
      user = BuffetOwner.create!(email: 'raf@el.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '20757307000149', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      event = Event.create!(name: 'Casamento Galaxy Buffet', description: 'um casamento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find_by(category: "wedding"),
                          exclusive_address: true, buffet: buffet)

      post event_holder_images_path(event.id), params: {holder_image: {image: fixture_file_upload(Rails.root.join('spec', 'support', 'image.jpg'), 'image/jpg')}}
      
      expect(response).to redirect_to root_path 
    end

    it "must be authorized" do
      load_categories
      user = BuffetOwner.create!(email: 'raf@el.com', password: 'password')
      user_2 = BuffetOwner.create!(email: 'r@fael.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '20757307000149', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      Buffet.create!(brand_name: 'Volcano Buffets', corporate_name: 'Geological fissure LTDA', 
                              registration: '35918380000122', phone_number: '99123456789', 
                              email: 'atendimento@lava.com', address: 'Rua explosion, 123',
                              district: 'underground', city: 'Tectonic rift', state_code: 'TT', 
                              zip_code: '99999-999', description: 'A blast of buffet', 
                              buffet_owner: user_2)
      event = Event.create!(name: 'Casamento Galaxy Buffet', description: 'um casamento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find_by(category: "wedding"),
                          exclusive_address: true, buffet: buffet)
      login_as user_2, scope: :buffet_owner
      
      post event_holder_images_path(event.id), params: {holder_image: {image: fixture_file_upload(Rails.root.join('spec', 'support', 'image.jpg'), 'image/jpg')}}
      
      expect(response).to redirect_to root_path 
      
    end
    
  end

  context "#event/destroy" do
    it "must be authenticated" do
      load_categories
      user = BuffetOwner.create!(email: 'raf@el.com', password: 'password')
      user_2 = BuffetOwner.create!(email: 'r@fael.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '20757307000149', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      Buffet.create!(brand_name: 'Volcano Buffets', corporate_name: 'Geological fissure LTDA', 
                              registration: '35918380000122', phone_number: '99123456789', 
                              email: 'atendimento@lava.com', address: 'Rua explosion, 123',
                              district: 'underground', city: 'Tectonic rift', state_code: 'TT', 
                              zip_code: '99999-999', description: 'A blast of buffet', 
                              buffet_owner: user_2)
      event = Event.create!(name: 'Casamento Galaxy Buffet', description: 'um casamento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find_by(category: "wedding"),
                          exclusive_address: true, buffet: buffet)
      image = HolderImage.create!(image: fixture_file_upload(Rails.root.join('spec', 'support', 'image.jpg')), user: user, holder: event)
      login_as user_2, scope: :buffet_owner

      delete event_holder_image_path(event.id, image.id)

      expect(response).to redirect_to root_path 
    end

  it "must be authorized" do
    load_categories
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '20757307000149', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      event = Event.create!(name: 'Eventinho', description: 'um evento muito louco',
                            min_capacity: 20, max_capacity: 40, default_duration: 240,
                            menu: 'um monte de comida', event_category: EventCategory.find_by(category: "debutante_ball"),
                            exclusive_address: true, buffet: buffet)
      image = HolderImage.create!(image: fixture_file_upload(Rails.root.join('spec', 'support', 'image.jpg')), user: user, holder: event)
      
      delete event_holder_image_path(event.id, image.id)

      expect(response).to redirect_to root_path 
  end

  end

  context "#rate/create" do
    it "must be authenticated" do
      load_categories
      load_payments
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '20757307000149', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find_by(method: "cash"))
      event = Event.create!(name: 'Eventinho', description: 'um evento muito louco',
                            min_capacity: 20, max_capacity: 50, default_duration: 240,
                            menu: 'um monte de comida', event_category: EventCategory.find_by(category: "wedding"),
                            exclusive_address: true, buffet: buffet)
      EventPrice.create!(price_type: 0, base_value: 2000, extra_per_person: 120, extra_per_hour: 500, event: event)
      customer = Customer.create!(cpf: 33216336557, email: 'r@fael.com', password: 'password' )
      order = Order.create!(date: 2.weeks.from_now , people_count: 25, details: "Insira detalhes aqui...", 
                            event: event, customer: customer, status: 'confirmed')
      ServiceProposal.create!(value: 2000, extra_fee: 100, discount: 200, 
                                        description: "100 reais de frete e 10% de desconto no dinheiro", 
                                        payment_method_id: PaymentMethod.find_by(method: "cash").id,
                                        order: order, expiration_date: 1.week.from_now, status:'confirmed')
      rate = Rate.create!(score: 2, comment: 'Razoavel', customer: customer, buffet: buffet)

      post rate_holder_images_path(rate.id), params: {holder_image: {image: fixture_file_upload(Rails.root.join('spec', 'support', 'image.jpg'), 'image/jpg')}}

      expect(response).to redirect_to root_path
    end

    it "must be authorized" do
      load_categories
      load_payments
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '20757307000149', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find_by(method: "cash"))
      event = Event.create!(name: 'Eventinho', description: 'um evento muito louco',
                            min_capacity: 20, max_capacity: 50, default_duration: 240,
                            menu: 'um monte de comida', event_category: EventCategory.find_by(category: "wedding"),
                            exclusive_address: true, buffet: buffet)
      EventPrice.create!(price_type: 0, base_value: 2000, extra_per_person: 120, extra_per_hour: 500, event: event)
      customer = Customer.create!(cpf: 33216336557, email: 'r@fael.com', password: 'password' )
      customer_1 = Customer.create!(cpf: 52727228090, email: 'ra@fael.com', password: 'password' )
      order = Order.create!(date: 2.weeks.from_now , people_count: 25, details: "Insira detalhes aqui...", 
                            event: event, customer: customer, status: 'confirmed')
      ServiceProposal.create!(value: 2000, extra_fee: 100, discount: 200, 
                                        description: "100 reais de frete e 10% de desconto no dinheiro", 
                                        payment_method_id: PaymentMethod.find_by(method: "cash").id,
                                        order: order, expiration_date: 1.week.from_now, status:'confirmed')
      rate = Rate.create!(score: 2, comment: 'Razoavel', customer: customer, buffet: buffet)
      login_as customer_1, scope: :customer

      post rate_holder_images_path(rate.id), params: {holder_image: {image: fixture_file_upload(Rails.root.join('spec', 'support', 'image.jpg'), 'image/jpg')}}

      expect(response).to redirect_to root_path

    end
  end
end
