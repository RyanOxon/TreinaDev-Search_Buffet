require 'rails_helper'

describe "user view rating of a buffet" do
  it "average on buffet details" do
    load_categories
    load_payments
    user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
    buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                            registration: '321.543.12/0001-33', phone_number: '99123456789', 
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
    Rate.create!(score: 2, comment: 'Razoavel', customer: customer, buffet: buffet)
    Rate.create!(score: 0, comment: 'Ruim', customer: customer, buffet: buffet)
    Rate.create!(score: 4, comment: 'Bom', customer: customer, buffet: buffet)

    visit root_path
    click_on 'Galaxy Buffet'

    expect(page).to have_content('Avaliação média: 2.0') 
  end
  it "and see the last 3 comments on buffet details" do
    load_categories
    load_payments
    user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
    buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                            registration: '321.543.12/0001-33', phone_number: '99123456789', 
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
    Rate.create!(score: 2, comment: 'Razoavel', customer: customer, buffet: buffet)
    Rate.create!(score: 0, comment: 'Ruim', customer: customer, buffet: buffet)
    Rate.create!(score: 4, comment: 'Bom', customer: customer, buffet: buffet)
    Rate.create!(score: 5, comment: 'Excelente', customer: customer, buffet: buffet)

    visit root_path
    click_on 'Galaxy Buffet'

    expect(page).to have_content 'Ultimas Avaliações'
    expect(page).not_to have_content 'Nota: 2'
    expect(page).not_to have_content 'Razoavel' 
    expect(page).to have_content 'Nota: 0'
    expect(page).to have_content 'Ruim'
    expect(page).to have_content 'Nota: 4'
    expect(page).to have_content 'Bom'
    expect(page).to have_content 'Nota: 5'
    expect(page).to have_content 'Excelente'

  end

  it "go to rate details by clicking one of the 3 rates" do
    load_categories
    load_payments
    user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
    buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                            registration: '321.543.12/0001-33', phone_number: '99123456789', 
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
    Rate.create!(score: 2, comment: 'Razoavel', customer: customer, buffet: buffet)
    rate = Rate.create!(score: 0, comment: 'Ruim', customer: customer, buffet: buffet)
    Rate.create!(score: 4, comment: 'Bom', customer: customer, buffet: buffet)
    Rate.create!(score: 5, comment: 'Excelente', customer: customer, buffet: buffet)

    visit root_path
    click_on 'Galaxy Buffet'
    click_on 'Ruim'

    expect(current_path).to eq buffet_rate_path(buffet, rate)

  end

  it "if theres more than 3 ratings show a button to see more" do
    load_categories
    load_payments
    user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
    buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                            registration: '321.543.12/0001-33', phone_number: '99123456789', 
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
    Rate.create!(score: 2, comment: 'Razoavel', customer: customer, buffet: buffet)
    Rate.create!(score: 0, comment: 'Ruim', customer: customer, buffet: buffet)
    Rate.create!(score: 4, comment: 'Bom', customer: customer, buffet: buffet)
    Rate.create!(score: 5, comment: 'Excelente', customer: customer, buffet: buffet)

    visit root_path
    click_on 'Galaxy Buffet'

    expect(page).to have_content 'Ultimas Avaliações'
    expect(page).to have_link 'Ver mais'

  end

  it "and see all comments when click on button" do
    load_categories
    load_payments
    user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
    buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                            registration: '321.543.12/0001-33', phone_number: '99123456789', 
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
    Rate.create!(score: 2, comment: 'Razoavel', customer: customer, buffet: buffet)
    Rate.create!(score: 0, comment: 'Ruim', customer: customer, buffet: buffet)
    Rate.create!(score: 4, comment: 'Bom', customer: customer, buffet: buffet)
    Rate.create!(score: 5, comment: 'Excelente', customer: customer, buffet: buffet)

    visit root_path
    click_on 'Galaxy Buffet'
    click_on 'Ver mais'

    expect(page).to have_content 'Avaliações Galaxy Buffet'
    expect(page).to have_content 'Nota: 2'
    expect(page).to have_content 'Razoavel' 
    expect(page).to have_content 'Nota: 0'
    expect(page).to have_content 'Ruim'
    expect(page).to have_content 'Nota: 4'
    expect(page).to have_content 'Bom'
    expect(page).to have_content 'Nota: 5'
    expect(page).to have_content 'Excelente'

  end  
  
end
