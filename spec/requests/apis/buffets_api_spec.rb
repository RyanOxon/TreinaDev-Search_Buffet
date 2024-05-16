require 'rails_helper'

describe "Buffet API" do
  context "GET /api/v1/buffets" do
    it "sucessfully" do
      load_payments
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      user_2 = BuffetOwner.create!(email: 'r@e.com', password: 'password')
      user_3 = BuffetOwner.create!(email: 'ra@e.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '07267705000119', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find_by(method: "credit_card"))
      buffet_2 = Buffet.create!(brand_name: 'Volcano Buffets', corporate_name: 'Geological fissure LTDA', 
                              registration: '56673136000117', phone_number: '99123456789', 
                              email: 'atendimento@lava.com', address: 'Rua explosion, 123',
                              district: 'underground', city: 'Tectonic rift', state_code: 'TT', 
                              zip_code: '99999-999', description: 'A blast of buffet', 
                              buffet_owner: user_2)
      BuffetPaymentMethod.create!(buffet: buffet_2, payment_method: PaymentMethod.find_by(method: "credit_card"))
      buffet_3 = Buffet.create!(brand_name: 'Comida a kilo', corporate_name: 'Geologica fissure LTDA', 
                              registration: '35918380000122', phone_number: '99123456789', 
                              email: 'atendimento@lava.com', address: 'Rua explosion, 123',
                              district: 'underground', city: 'Tectonic rift', state_code: 'TT', 
                              zip_code: '99999-999', description: 'A blast of buffet', 
                              buffet_owner: user_3)
      BuffetPaymentMethod.create!(buffet: buffet_3, payment_method: PaymentMethod.find_by(method: "credit_card"))

      get "/api/v1/buffets"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 3
      expect(json_response[0]["brand_name"]).to eq  "Galaxy Buffet"
      expect(json_response[0]["city"]).to eq  "Via lactea"
      expect(json_response[0]["state_code"]).to eq  "AA"
      expect(json_response[0]["payment_methods"][0]["humanized_method_name"]).to eq  "Cartão de Credito"
      expect(json_response[0].keys).not_to include 'corporate_name'
      expect(json_response[0].keys).not_to include 'registration'
      expect(json_response[0].keys).not_to include 'created_at'
      expect(json_response[0].keys).not_to include 'updated_at'
      expect(json_response[1]["brand_name"]).to eq  "Volcano Buffets" 
      expect(json_response[2]["brand_name"]).to eq  "Comida a kilo" 
    end

    it "with params" do
      load_payments
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      user_2 = BuffetOwner.create!(email: 'r@e.com', password: 'password')
      user_3 = BuffetOwner.create!(email: 'ra@e.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '07267705000119', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find_by(method: "credit_card"))
      buffet_2 = Buffet.create!(brand_name: 'Volcano Buffets', corporate_name: 'Geological fissure LTDA', 
                              registration: '56673136000117', phone_number: '99123456789', 
                              email: 'atendimento@lava.com', address: 'Rua explosion, 123',
                              district: 'underground', city: 'Tectonic rift', state_code: 'TT', 
                              zip_code: '99999-999', description: 'A blast of buffet', 
                              buffet_owner: user_2)
      BuffetPaymentMethod.create!(buffet: buffet_2, payment_method: PaymentMethod.find_by(method: "credit_card"))
      buffet_3 = Buffet.create!(brand_name: 'Comida a kilo', corporate_name: 'Geologica fissure LTDA', 
                              registration: '22300696000104', phone_number: '99123456789', 
                              email: 'atendimento@lava.com', address: 'Rua explosion, 123',
                              district: 'underground', city: 'Tectonic rift', state_code: 'TT', 
                              zip_code: '99999-999', description: 'A blast of buffet', 
                              buffet_owner: user_3)
      BuffetPaymentMethod.create!(buffet: buffet_3, payment_method: PaymentMethod.find_by(method: "credit_card"))

      get "/api/v1/buffets?search=Buffet"
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2
      expect(json_response[0]["brand_name"]).to eq  "Galaxy Buffet"
      expect(json_response[1]["brand_name"]).to eq  "Volcano Buffets" 



    end

    it "and is empty" do

      get "/api/v1/buffets"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response).to eq [] 

    end


  end
  context "GET /api/v1/buffets/1" do
    it "sucessfully" do
      load_payments
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '07267705000119', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find_by(method: "credit_card"))

      get "/api/v1/buffets/#{buffet.id}"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response["brand_name"]).to eq 'Galaxy Buffet'
      expect(json_response["phone_number"]).to eq '99123456789'
      expect(json_response["email"]).to eq 'atendimento@buffyts.com'
      expect(json_response["address"]).to eq 'Rua Estrelas, 123'
      expect(json_response["district"]).to eq 'Sistema Solar'
      expect(json_response["city"]).to eq 'Via lactea'
      expect(json_response["state_code"]).to eq 'AA'
      expect(json_response["zip_code"]).to eq '99999-999'
      expect(json_response["description"]).to eq 'Um buffet de outro mundo'
      expect(json_response["payment_methods"][0]["humanized_method_name"]).to eq "Cartão de Credito"
      expect(json_response.keys).not_to include 'corporate_name'
      expect(json_response.keys).not_to include 'registration'
      expect(json_response.keys).not_to include 'created_at'
      expect(json_response.keys).not_to include 'updated_at'
    end

    it "not found" do
      get "/api/v1/buffets/9999999999"

      expect(response.status).to eq 404
    end
    
  end
  context "GET /api/v1/buffets/1/events" do
    it "sucessfully" do
      load_payments
      load_categories
      load_features
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '07267705000119', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find_by(method: "credit_card"))
      event = Event.create!(name: 'Casamento Galaxy Buffet', description: 'um evento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find_by(category: "wedding"),
                          exclusive_address: true, buffet: buffet)
      EventFeature.create!(event: event, feature: Feature.find_by(feature: "alcohol"))
      EventFeature.create!(event: event, feature: Feature.find_by(feature: "decoration"))
      EventPrice.create!(price_type: 0, base_value: 100000, extra_per_person: 1000, extra_per_hour: 20000, event: event)
      EventPrice.create!(price_type: 1, base_value: 200000, extra_per_person: 2000, extra_per_hour: 40000, event: event)

      Event.create!(name: 'Corporativo Galaxy Buffet', description: 'um evento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find_by(category: "corporate"),
                          exclusive_address: true, buffet: buffet)

      get "/api/v1/buffets/#{buffet.id}/events"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2
      expect(json_response[0]["name"]).to eq "Casamento Galaxy Buffet"
      expect(json_response[0]["description"]).to eq "um evento muito louco"
      expect(json_response[0]["min_capacity"]).to eq 20
      expect(json_response[0]["max_capacity"]).to eq 40
      expect(json_response[0]["default_duration"]).to eq 240
      expect(json_response[0]["menu"]).to eq "um monte de comida"
      expect(json_response[0]["exclusive_address"]).to eq true
      expect(json_response[0]["event_category"]["category"]).to eq "wedding"
      expect(json_response[0]["features"][0]["humanized_feature_name"]).to eq "Bebidas alcoolicas"
      expect(json_response[0]["features"][1]["humanized_feature_name"]).to eq "Decoração"
      expect(json_response[0]["event_prices"][0]["humanized_price_name"]).to eq "Preço dias de semana"
      expect(json_response[0]["event_prices"][0]["base_value"]).to eq 100000
      expect(json_response[0]["event_prices"][0]["extra_per_person"]).to eq 1000
      expect(json_response[0]["event_prices"][0]["extra_per_hour"]).to eq 20000
      expect(json_response[0]["event_prices"][1]["humanized_price_name"]).to eq "Preço final de semana e feriados"
      expect(json_response[0].keys).not_to include 'created_at'
      expect(json_response[0].keys).not_to include 'updated_at'
      expect(json_response[0].keys).not_to include 'buffet_id'
      expect(json_response[0].keys).not_to include 'event_category_id'

    end
    it 'and fails' do
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '07267705000119', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)

      get "/api/v1/buffets/#{buffet.id}/events"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response).to eq [] 
    end
  end
  context "GET /api/v1/buffets/1/events/1/availability" do
    it "sucessfully" do
      load_categories
      load_payments
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '07267705000119', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      event = Event.create!(name: 'Casamento Galaxy Buffet', description: 'um casamento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find_by(category: "wedding"),
                          exclusive_address: false, buffet: buffet)
      EventPrice.create!(price_type: 0, base_value: 2000, extra_per_person: 120, extra_per_hour: 500, event: event)
      customer = Customer.create!(cpf: 33216336557, email: 'r@fael.com', password: 'password' )
      order = Order.create!(date: 1.year.from_now , people_count: 25, details: "Insira detalhes aqui...", event: event, customer: customer, status: 'negotiating')
      ServiceProposal.create!(value: 2000, extra_fee: 100, discount: 200, 
                              description: "100 reais de frete e 10% de desconto no dinheiro", 
                              payment_method_id: PaymentMethod.find_by(method: "cash").id,
                              order: order, expiration_date: 1.month.from_now)

      get "/api/v1/buffets/#{buffet.id}/events/#{event.id}/availability?date=#{5.months.from_now}&num_people=30"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response["available"]).to eq true

    end
    it "with no params" do
      load_categories
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '07267705000119', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      event = Event.create!(name: 'Casamento Galaxy Buffet', description: 'um casamento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find_by(category: "wedding"),
                          exclusive_address: false, buffet: buffet)

      EventPrice.create!(price_type: 0, base_value: 2000, extra_per_person: 120, extra_per_hour: 500, event: event)
      

      get "/api/v1/buffets/#{buffet.id}/events/#{event.id}/availability"

      expect(response.status).to eq 400
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response["error"]).to eq 'Missing required parameters'

    end
    it "date is not available for the buffet" do
      load_categories
      load_payments
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '07267705000119', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      event = Event.create!(name: 'Casamento Galaxy Buffet', description: 'um casamento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find_by(category: "wedding"),
                          exclusive_address: false, buffet: buffet)
      EventPrice.create!(price_type: 0, base_value: 2000, extra_per_person: 120, extra_per_hour: 500, event: event)
      event_2 = Event.create!(name: 'Corporativo Galaxy Buffet', description: 'um evento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find_by(category: "corporate"),
                          exclusive_address: true, buffet: buffet)
      EventPrice.create!(price_type: 0, base_value: 2000, extra_per_person: 120, extra_per_hour: 500, event: event_2)

      customer = Customer.create!(cpf: 33216336557, email: 'r@fael.com', password: 'password' )
      order = Order.create!(date: 1.year.from_now , people_count: 25, details: "Insira detalhes aqui...", event: event_2, customer: customer, status: 'negotiating')

      get "/api/v1/buffets/#{buffet.id}/events/#{event.id}/availability?date=#{order.date}&num_people=30"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response["available"]).to eq false
      expect(json_response["reason"]).to eq "date is not available"

    end
    it "not avaible only if theres a order being negotiated or confirmed" do
      load_categories
      load_payments
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '07267705000119', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      event = Event.create!(name: 'Casamento Galaxy Buffet', description: 'um casamento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find_by(category: "wedding"),
                          exclusive_address: false, buffet: buffet)
      EventPrice.create!(price_type: 0, base_value: 2000, extra_per_person: 120, extra_per_hour: 500, event: event)
      customer = Customer.create!(cpf: 33216336557, email: 'r@fael.com', password: 'password' )
      order = Order.create!(date: 1.year.from_now , people_count: 25, details: "Insira detalhes aqui...", event: event, customer: customer)

      get "/api/v1/buffets/#{buffet.id}/events/#{event.id}/availability?date=#{order.date}&num_people=40"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response["available"]).to eq true
      
    end
    it "and number of people exceed event limit" do
      load_categories
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '07267705000119', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      event = Event.create!(name: 'Casamento Galaxy Buffet', description: 'um casamento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find_by(category: "wedding"),
                          exclusive_address: false, buffet: buffet)
      EventPrice.create!(price_type: 0, base_value: 2000, extra_per_person: 120, extra_per_hour: 500, event: event)
      customer = Customer.create!(cpf: 33216336557, email: 'r@fael.com', password: 'password' )
      order = Order.create!(date: 1.year.from_now , people_count: 25, details: "Insira detalhes aqui...", event: event, customer: customer)

      get "/api/v1/buffets/#{buffet.id}/events/#{event.id}/availability?date=#{order.date}&num_people=50"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response["available"]).to eq false
      expect(json_response["reason"]).not_to eq "date is not available"
      expect(json_response["reason"]).to eq "number of people exceed event limit"

    end
    it "event doesnt exist" do
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '07267705000119', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      
      get "/api/v1/buffets/#{buffet.id}/events/99999/availability?date=2025-12-31&num_people=30"

      expect(response.status).to eq 404
    end
    

  end
end
