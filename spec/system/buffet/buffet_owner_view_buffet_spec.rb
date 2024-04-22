require 'rails_helper'

describe "buffet owner view his buffet" do
  it "from navbar" do
    load_payments
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
      click_on "Meu Buffet"
    end

    expect(page).to have_content "Galaxy Buffet" 
    expect(page).to have_content "Buffetys LTDA"
    expect(page).to have_content "321.543.12/0001-33"
    
  end

  it "after log in" do
    load_payments
    user = BuffetOwner.create!(email: 'rafa@el.com', password: "password")
    buffet = Buffet.create!(brand_name: "Galaxy Buffet", corporate_name: "Buffetys LTDA", 
                            registration: "321.543.12/0001-33", phone_number: "99123456789", 
                            email: "atendimento@buffyts.com", address: "Rua Estrelas, 123",
                            district: "Sistema Solar", city: "Via lactea", state_code: "AA", 
                            zip_code: "99999-999", description: "Um buffet de outro mundo", 
                            buffet_owner: user)
    BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find(1))

    visit root_path

    within 'div#owners' do
    click_on "Logar"
    end

    fill_in "E-mail",	with: "rafa@el.com"
    fill_in "Senha",	with: "password"
    click_on "Log in"

    expect(current_path).to eq buffet_path(buffet.id)
    expect(page).to have_content "Galaxy Buffet" 
    expect(page).to have_content "Buffetys LTDA"
    expect(page).to have_content "321.543.12/0001-33"
    
  end
end
