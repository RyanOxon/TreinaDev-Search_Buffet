require 'rails_helper'

describe "buffet owner edit one of his events" do
  it "from event details" do
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
    BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find_by(method: "cash"))
    event = Event.create!(name: 'Eventinho', description: 'um evento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find_by(category: "debutante_ball"),
                          exclusive_address: true, buffet: buffet)
    EventFeature.create!(event: event, feature: Feature.find_by(feature: "alcohol"))
    login_as user, scope: :buffet_owner
    
    visit root_path
    within 'nav' do
      click_on 'Lista de Eventos'
    end
    click_on 'Eventinho'
    click_on 'Editar evento'
    expect(page).to have_content "Editar evento"
    expect(page).to have_field "Titulo do anuncio"
    expect(page).to have_field "Descrição"
    expect(page).to have_field "Capacidade minima"
    expect(page).to have_field "Capacidade maxima"
    expect(page).to have_field "Duração padrão"
    expect(page).to have_field "Cardápio"
    expect(page).to have_field "Sim"
    expect(page).to have_field "Não"
    expect(page).to have_select "Tipo de evento"
    expect(page).to have_content "Caracteristicas inclusas"
    expect(page).to have_checked_field "Bebidas alcoolicas"
    expect(page).to have_unchecked_field "Decoração"
    expect(page).to have_unchecked_field "Estacionamento"
    expect(page).to have_unchecked_field "Manobrista"
     
  end
  
  it "sucessfully" do
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
    BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find_by(method: "credit_card"))
    event = Event.create!(name: 'Eventinho', description: 'um evento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find_by(category: "debutante_ball"),
                          exclusive_address: true, buffet: buffet)
    EventFeature.create!(event: event, feature: Feature.find_by(feature: "alcohol"))
    login_as user, scope: :buffet_owner
    
    visit root_path
    within 'nav' do
      click_on 'Lista de Eventos'
    end
    click_on 'Eventinho'
    click_on 'Editar evento'
    select "Aniversario", from: "Tipo de evento"
    fill_in "Titulo do anuncio",	with: "Aniversario para 40 pessoas no precin"
    fill_in "Capacidade minima",	with: "40" 
    fill_in "Capacidade maxima",	with: "80"
    fill_in "Duração padrão", with: "240"
    fill_in "Descrição",	with: "Melhor pacote para evento de aniversarios..."
    fill_in "Cardápio",	with: "Comida, comida, comida, comida, bebida, bebida"
    check "Decoração"
    choose "Sim"
    click_on "Atualizar Evento"
    
    expect(page).to have_content 'Evento atualizado com sucesso' 
    expect(page).to have_content "Aniversario para 40 pessoas no precin"
    expect(page).not_to have_content  'Eventinho' 
    
  end
  
  it "with incomplete data" do
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
    BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find_by(method: "credit_card"))
    event = Event.create!(name: 'Eventinho', description: 'um evento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find_by(category: "debutante_ball"),
                          exclusive_address: false, buffet: buffet)
    EventFeature.create!(event: event, feature: Feature.find_by(feature: "alcohol"))
    login_as user, scope: :buffet_owner
    
    visit root_path
    within 'nav' do
      click_on 'Lista de Eventos'
    end
    click_on 'Eventinho'
    click_on 'Editar evento'
    select "Aniversario", from: "Tipo de evento"
    fill_in "Titulo do anuncio",	with: "Aniversario para 40 pessoas no precin"
    fill_in "Capacidade minima",	with: "" 
    fill_in "Capacidade maxima",	with: "80"
    fill_in "Duração padrão", with: "240"
    fill_in "Descrição",	with: "Melhor pacote para evento de aniversarios..."
    fill_in "Cardápio",	with: "Comida, comida, comida, comida, bebida, bebida"
    check "Decoração"
    choose "Sim"
    click_on "Atualizar Evento"

    expect(page).to have_content 'Erro ao atualizar evento'
    
  end

  xit "only if authorized" do
      
  end

end
