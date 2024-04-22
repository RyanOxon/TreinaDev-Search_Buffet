require "rails_helper"

describe "buffet owner register event" do
  it "from navbar" do
    load_payments
    load_features
    load_categories
    user = BuffetOwner.create!(email: 'rafa@el.com', password: "password")
    buffet = Buffet.create!(brand_name: "Galaxy Buffet", corporate_name: "Buffetys LTDA", 
                            registration: "321.543.12/0001-33", phone_number: "99123456789", 
                            email: "atendimento@buffyts.com", address: "Rua Estrelas, 123",
                            district: "Sistema Solar", city: "Via lactea", state_code: "AA", 
                            zip_code: "99999-999", description: "Um buffet de outro mundo", 
                            buffet_owner: user)
    BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find(1))
    login_as user
    visit root_path

    within 'nav' do
      click_on "Anunciar Evento"
    end
    expect(page).to have_content "Cadastrar novo evento"
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
    expect(page).to have_unchecked_field "Bebidas alcoolicas"
    expect(page).to have_unchecked_field "Decoração"
    expect(page).to have_unchecked_field "Estacionamento"
    expect(page).to have_unchecked_field "Manobrista"
  end

  it "sucessfully" do
    load_payments
    load_features
    load_categories
    user = BuffetOwner.create!(email: 'rafa@el.com', password: "password")
    buffet = Buffet.create!(brand_name: "Galaxy Buffet", corporate_name: "Buffetys LTDA", 
                            registration: "321.543.12/0001-33", phone_number: "99123456789", 
                            email: "atendimento@buffyts.com", address: "Rua Estrelas, 123",
                            district: "Sistema Solar", city: "Via lactea", state_code: "AA", 
                            zip_code: "99999-999", description: "Um buffet de outro mundo", 
                            buffet_owner: user)
    BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find(1))
    login_as user
    visit root_path

    within 'nav' do
      click_on "Anunciar Evento"
    end
    select "Aniversario", from: "Tipo de evento"
    fill_in "Titulo do anuncio",	with: "Aniversario para 40 pessoas no precin"
    fill_in "Capacidade minima",	with: "40" 
    fill_in "Capacidade maxima",	with: "80"
    fill_in "Duração padrão", with: "240"
    fill_in "Descrição",	with: "Melhor pacote para evento de aniversarios..."
    fill_in "Cardápio",	with: "Comida, comida, comida, comida, bebida, bebida"
    check "Decoração"
    choose "Sim"
    click_on "Criar Evento"

    expect(page).to have_content "Evento cadastrado com sucesso"
    expect(page).not_to have_content "Erro ao cadastrar evento"
    expect(page).to have_content "Tipo de evento: Aniversario"
    expect(page).to have_content "Aniversario para 40 pessoas no precin"
    expect(page).to have_content "Capacidade: minimo 40 e maximo 80"
    expect(page).to have_content "4 horas"
    expect(page).to have_content "Melhor pacote para evento de aniversarios..."
    expect(page).to have_content "Comida, comida, comida, comida, bebida, bebida"
    expect(page).to have_content "Decoração"
    expect(page).to have_content "Endereço Exclusivo: Sim"
  end
  
    it "and is not sign in" do
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
      BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find(1))

      visit new_event_path

      expect(page).to have_content 'Para continuar, faça login ou registre-se.'
    end
    
  
end
