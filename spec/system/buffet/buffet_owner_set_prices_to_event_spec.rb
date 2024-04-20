require "rails_helper"

describe "buffet owner set prices to his event" do
  it "from the event details" do
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
    event = Event.create!(name: "Eventinho", description: "um evento muito louco",
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: "um monte de comida", event_category: EventCategory.find(1),
                          exclusive_address: true, buffet: buffet)
    EventFeature.create!(event: event, feature: Feature.find(1))
    login_as user
    
    visit root_path
    within 'nav' do
      click_on 'Lista de Eventos'
    end
    click_on "Eventinho"
    click_on "Informar preço-base"

    expect(page).to have_content "Preço-base"
    expect(page).to have_select "Tipo de valor"
    expect(page).to have_field "Valor base"
    expect(page).to have_field "Adicional por pessoa"
    expect(page).to have_field "Adicional por hora"

  end
end
