require 'rails_helper'

describe "customer rates a buffet" do
  it "from buffet details" do
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
                                      order: order, expiration_date: 1.week.from_now,
                                      status: 'confirmed')
    login_as customer, scope: :customer

    travel 1.month do
      visit root_path
      click_on 'Galaxy Buffet'
      click_on 'Avaliar Buffet'

      expect(page).to have_field 'Nota'
      expect(page).to have_field 'Comentário' 
      expect(page).to have_button 'Criar Avaliação' 
    end
  end

  it "only if has a completed order" do
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
    order = Order.create!(date: 6.weeks.from_now , people_count: 25, details: "Insira detalhes aqui...", 
                          event: event, customer: customer, status: 'negotiating')    
    ServiceProposal.create!(value: 2000, extra_fee: 100, discount: 200, 
                                      description: "100 reais de frete e 10% de desconto no dinheiro", 
                                      payment_method_id: PaymentMethod.find_by(method: "cash").id,
                                      order: order, expiration_date: 1.week.from_now,
                                      status: 'waiting')
    login_as customer, scope: :customer

    travel 1.month
    visit root_path
    click_on 'Galaxy Buffet'

    expect(page).not_to have_link 'Avaliar Buffet' 
  end

  it "only if has a completed order on the last 30 days" do
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
                                      order: order, expiration_date: 1.week.from_now,
                                      status: 'waiting')
    login_as customer, scope: :customer

    travel 2.month
    visit root_path
    click_on 'Galaxy Buffet'

    expect(page).not_to have_link 'Avaliar Buffet' 
  end

  it "sucessfully" do
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
    login_as customer, scope: :customer

    travel 1.month
    visit root_path
    click_on 'Galaxy Buffet'
    click_on 'Avaliar Buffet'
    fill_in "Nota",	with: "5"
    fill_in "Comentário",	with: "Muito bom!"
    click_on 'Criar Avaliação'


    expect(page).to have_content('Avaliação enviada com sucesso!')
    expect(current_path).to eq buffet_rate_path(buffet, Rate.last)
    expect(page).to have_content "Muito bom!"
    expect(page).to have_content "5"
    expect(page).to have_content "r@fael.com"
    expect(page).to have_content "#{I18n.localize(Rate.last.rated_at, format: :short)}"
  end
    
  it "and must fill in all fields" do
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
    login_as customer, scope: :customer

    travel 1.month
    visit root_path
    click_on 'Galaxy Buffet'
    click_on 'Avaliar Buffet'
    fill_in "Nota",	with: "5"
    fill_in "Comentário",	with: ""
    click_on 'Criar Avaliação'

    expect(page).to have_content "Erro ao enviar avaliação!"
    expect(page).to have_content "Comentário não pode ficar em branco"
  end

  it "and have the option to add image on rate details" do
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
    rate = Rate.create!(score: 2, comment: 'Razoavel', customer: customer, buffet: buffet)
    login_as customer, scope: :customer
    
    visit buffet_rate_path(buffet, rate)

    expect(page).to have_content 'Imagens'
    expect(page).to have_content 'Escolha um arquivo…'
    expect(page).to have_content 'Nenhum arquivo selecionado'
    expect(page).to have_field 'file-input'
    expect(page).to have_button 'Salvar Imagem'

  end
  
  it "add image sucessfully" do
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
    rate = Rate.create!(score: 2, comment: 'Razoavel', customer: customer, buffet: buffet)
    login_as customer, scope: :customer

    visit buffet_rate_path(buffet, rate)

    attach_file 'file-input', Rails.root.join('spec', 'support', 'image.jpg')
    click_on 'Salvar Imagem'

    expect(page).to have_content "Imagem anexada com sucesso"
    expect(page).to have_css'img[src*="image.jpg"]'

  end

  it "and must be logged in" do
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
    rate = Rate.create!(score: 2, comment: 'Razoavel', customer: customer, buffet: buffet)

    visit buffet_rate_path(buffet, rate)

    expect(page).to have_content 'Imagens'
    expect(page).not_to have_content 'Escolha um arquivo…'
    expect(page).not_to have_content 'Nenhum arquivo selecionado'
    expect(page).not_to have_field 'file-input'
    expect(page).not_to have_button 'Salvar Imagem'

  end

  it "cannot add no image" do
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
    rate = Rate.create!(score: 2, comment: 'Razoavel', customer: customer, buffet: buffet)
    login_as customer, scope: :customer

    visit buffet_rate_path(buffet, rate)

    click_on 'Salvar Imagem'

    expect(page).to have_content "Erro ao anexar imagem"

  end
  
end
