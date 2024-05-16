require 'rails_helper'

describe 'Buffet owner set event as disable' do
  it 'from event details' do
    load_categories
    user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
    buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                            registration: '321.543.12/0001-33', phone_number: '99123456789', 
                            email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                            district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                            zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                            buffet_owner: user)
    Event.create!(name: 'Eventinho', description: 'um evento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find_by(category: "debutante_ball"),
                          exclusive_address: true, buffet: buffet)
    login_as user, scope: :buffet_owner

    visit root_path
    within 'nav' do
      click_on 'Lista de Eventos'
    end
    click_on 'Eventinho'

    expect(page).to have_button "Desativar Evento"

  end

  it 'sucessfully' do
    load_categories
    user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
    buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                            registration: '321.543.12/0001-33', phone_number: '99123456789', 
                            email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                            district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                            zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                            buffet_owner: user)
    Event.create!(name: 'Eventinho', description: 'um evento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find_by(category: "debutante_ball"),
                          exclusive_address: true, buffet: buffet)
    login_as user, scope: :buffet_owner

    visit root_path
    within 'nav' do
      click_on 'Lista de Eventos'
    end
    click_on 'Eventinho'
    click_on 'Desativar Evento'

    expect(page).to have_content 'Evento desativado com sucesso'
    expect(page).to have_content 'Reativar Evento'
    expect(page).to have_content 'Eventinho (Desativado)'
  end

  it 'and should not see it in the buffet detail events list' do
    load_categories
    user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
    buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                            registration: '321.543.12/0001-33', phone_number: '99123456789', 
                            email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                            district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                            zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                            buffet_owner: user)
    Event.create!(name: 'Eventinho', description: 'um evento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find_by(category: "debutante_ball"),
                          exclusive_address: true, buffet: buffet)
    Event.create!(name: 'Eventinho 2', description: 'um outro evento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida denovo', event_category: EventCategory.find_by(category: "debutante_ball"),
                          exclusive_address: true, buffet: buffet, active: false)
    login_as user, scope: :buffet_owner

    visit root_path

    expect(page).to have_content 'Eventinho'
    expect(page).not_to have_content 'Eventinho 2'

  end

  it 'and keep seeing in events list' do
    load_categories
    user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
    buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                            registration: '321.543.12/0001-33', phone_number: '99123456789', 
                            email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                            district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                            zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                            buffet_owner: user)
    Event.create!(name: 'Eventinho', description: 'um evento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find_by(category: "debutante_ball"),
                          exclusive_address: true, buffet: buffet)
    Event.create!(name: 'Eventinho 2', description: 'um outro evento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida denovo', event_category: EventCategory.find_by(category: "debutante_ball"),
                          exclusive_address: true, buffet: buffet, active: false)
    login_as user, scope: :buffet_owner

    visit root_path
    within 'nav' do
      click_on 'Lista de Eventos'
    end

    expect(page).to have_content 'Eventinho'
    expect(page).to have_content 'Eventinho 2 (Desativado)'
  end

  it 'cannot receive nem orders' do
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
                        exclusive_address: true, buffet: buffet, active: false)
    Event.create!(name: 'Corporativo Galaxy Buffet', description: 'Buffet para eventos corporativo',
                        min_capacity: 20, max_capacity: 40, default_duration: 240,
                        menu: 'Comida, comida, comida, comida, bebida, bebida', event_category: EventCategory.find_by(category: "corporate"),
                        exclusive_address: true, buffet: buffet)
    customer = Customer.create!(cpf: 33216336557, email: 'r@fael.com', password: 'password' )
    login_as customer, scope: :customer

    visit new_event_order_path(event)

    expect(current_path).not_to eq new_event_order_path(event)
    expect(page).to have_content "Não é possivel abrir novos pedidos para este evento"

  end

  it "and keep active orders" do 
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
    customer = Customer.create!(cpf: 33216336557, email: 'r@fael.com', password: 'password' )
    order = Order.create!(date: 1.year.from_now , people_count: 25, details: "Insira detalhes aqui...", 
                          event: event, customer: customer, status: 'negotiating')
    ServiceProposal.create!(value: 2000, extra_fee: 100, discount: 200, 
                                      description: "100 reais de frete e 10% de desconto no dinheiro", 
                                      payment_method_id: PaymentMethod.find_by(method: "cash").id,
                                      order: order, expiration_date: 1.month.from_now)
    event.update(active: false)
    login_as customer, scope: :customer

    visit root_path
    within 'nav' do
      click_on 'Meus pedidos'
    end
    click_on "#{order.code}"

    expect(current_path).to eq order_path(order)
    expect(page).to have_content "Status do pedido: Proposta em negociação"
    expect(page).to have_content "Status: Aguardando confirmação do cliente"
    expect(page).to have_button "Aceitar proposta"
    expect(page).to have_button "Recusar proposta"
    expect(page).to have_button "Cancelar pedido"
  end

  it "and can reactived afterwards" do
    load_categories
    user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
    buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                            registration: '321.543.12/0001-33', phone_number: '99123456789', 
                            email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                            district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                            zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                            buffet_owner: user)
    Event.create!(name: 'Eventinho', description: 'um evento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find_by(category: "debutante_ball"),
                          exclusive_address: true, buffet: buffet)
    Event.create!(name: 'Eventinho 2', description: 'um outro evento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida denovo', event_category: EventCategory.find_by(category: "debutante_ball"),
                          exclusive_address: true, buffet: buffet, active: false)
    login_as user, scope: :buffet_owner

    visit root_path
    within 'nav' do
      click_on 'Lista de Eventos'
    end
    click_on 'Eventinho 2' 
    click_on 'Reativar'

    expect(page).to have_content 'Evento reativado com sucesso'
    expect(page).not_to have_content 'Eventinho 2 (Desativado)' 
  end
  
end
