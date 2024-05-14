require "rails_helper"

describe "Buffet owner edit his buffet" do
  it "from show page" do
    load_payments()
    user = BuffetOwner.create!(email: 'rafa@el.com', password: "password")
    buffet = Buffet.create!(brand_name: "Galaxy Buffet", corporate_name: "Buffetys LTDA", registration: "321.543.12/0001-33",
    phone_number: "99123456789", email: "atendimento@buffyts.com", address: "Rua Estrelas, 123",
    district: "Sistema Solar", city: "Via lactea", state_code: "AA", zip_code: "99999-999",
    description: "Um buffet de outro mundo", buffet_owner: user)
    BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find_by(method: "cash"))
    
    login_as user, scope: :buffet_owner
    visit root_path
    click_on "Meu Buffet"
    click_on "Editar"

    expect(page).to have_content 'Editar Buffet'
    expect(page).to have_field 'Nome fantasia', with: 'Galaxy Buffet'
    expect(page).to have_field 'Razão social'
    expect(page).to have_field 'CNPJ'
    expect(page).to have_field 'Endereço'
    expect(page).to have_field 'Cidade'
    expect(page).to have_field 'Codigo do estado'
    expect(page).to have_field 'E-mail de contato'
    expect(page).to have_field 'Telefone de contato'
    expect(page).to have_field 'Bairro'
    expect(page).to have_checked_field 'Dinheiro'   
    expect(page).to have_unchecked_field 'Cartão de Debito'
    expect(page).to have_unchecked_field 'Cartão de Credito'

  end
  
  it "sucessfully" do
    load_payments()
    user = BuffetOwner.create!(email: 'rafa@el.com', password: "password")
    buffet = Buffet.create!(brand_name: "Galaxy Buffet", corporate_name: "Buffetys LTDA", registration: "321.543.12/0001-33",
    phone_number: "99123456789", email: "atendimento@buffyts.com", address: "Rua Estrelas, 123",
    district: "Sistema Solar", city: "Via lactea", state_code: "AA", zip_code: "99999-999",
    description: "Um buffet de outro mundo", buffet_owner: user)
    BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find_by(method: "cash"))
    
    login_as user, scope: :buffet_owner
    visit root_path
    click_on "Meu Buffet"
    click_on "Editar"
    fill_in "Nome fantasia",	with: "Buffet da Praça"
    fill_in "Razão social",	with: "Buffets LTDA"
    fill_in "CNPJ",	with: "21.543.312/0001-33" 
    fill_in "Telefone de contato",	with: "00123456789"
    fill_in "E-mail de contato",	with: "atendimento@buffets.com"
    fill_in "Endereço",	with: "Rua Estrelas, 312"
    fill_in "Bairro",	with: "Sistema nao Solar" 
    fill_in "Cidade",	with: "Via queijo" 
    fill_in "Codigo do estado",	with: "XX"
    fill_in "CEP",	with: "99999-990" 
    uncheck "Dinheiro"
    check "Cartão de Debito"
    fill_in "Descrição",	with: "Um buffet de outro mundo"
    click_on "Atualizar Buffet"

    expect(page).to have_content "Buffet atualizado com sucesso" 
    expect(page).to have_content "Buffet da Praça"
    expect(page).to have_content "Buffets LTDA"
    expect(page).to have_content "21.543.312/0001-33"
    expect(page).to have_content "00123456789"
    expect(page).to have_content "atendimento@buffets.com"
    expect(page).to have_content "Rua Estrelas, 312"
    expect(page).to have_content "Sistema nao Solar"
    expect(page).to have_content "Via queijo"
    expect(page).to have_content "XX"
    expect(page).to have_content "99999-990"
    expect(page).to have_content "Um buffet de outro mundo"
    expect(page).not_to have_content "Dinheiro"
    expect(page).to have_content "Cartão de Debito"
  end

  it "with incomplete data" do
    load_payments()
    user = BuffetOwner.create!(email: 'rafa@el.com', password: "password")
    buffet = Buffet.create!(brand_name: "Galaxy Buffet", corporate_name: "Buffetys LTDA", registration: "321.543.12/0001-33",
    phone_number: "99123456789", email: "atendimento@buffyts.com", address: "Rua Estrelas, 123",
    district: "Sistema Solar", city: "Via lactea", state_code: "AA", zip_code: "99999-999",
    description: "Um buffet de outro mundo", buffet_owner: user)
    BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find_by(method: "cash"))
    
    login_as user, scope: :buffet_owner
    visit root_path
    click_on "Meu Buffet"
    click_on "Editar"
    fill_in "Nome fantasia",	with: "Buffet da Praça"
    fill_in "Razão social",	with: "Buffets LTDA"
    fill_in "CNPJ",	with:''
    fill_in "Telefone de contato",	with: "00123456789"
    fill_in "E-mail de contato",	with: "atendimento@buffets.com"
    fill_in "Endereço",	with: "Rua Estrelas, 312"
    fill_in "Bairro",	with: "Sistema nao Solar" 
    fill_in "Cidade",	with: "Via queijo" 
    fill_in "Codigo do estado",	with: "XX"
    fill_in "CEP",	with: "99999-990" 
    uncheck "Dinheiro"
    check "Cartão de Debito"
    fill_in "Descrição",	with: "Um buffet de outro mundo"
    click_on "Atualizar Buffet"

    expect(page).not_to have_content "Buffet atualizado com sucesso" 
    expect(page).to have_content "Erro ao atualizar Buffet"
    expect(page).to have_content "CNPJ não pode ficar em branco"

  end

  it "with no payment method" do
    load_payments()
    user = BuffetOwner.create!(email: 'rafa@el.com', password: "password")
    buffet = Buffet.create!(brand_name: "Galaxy Buffet", corporate_name: "Buffetys LTDA", registration: "321.543.12/0001-33",
                            phone_number: "99123456789", email: "atendimento@buffyts.com", address: "Rua Estrelas, 123",
                            district: "Sistema Solar", city: "Via lactea", state_code: "AA", zip_code: "99999-999",
                            description: "Um buffet de outro mundo", buffet_owner: user)
    BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find_by(method: "cash"))
    
    login_as user, scope: :buffet_owner
    visit root_path
    click_on "Meu Buffet"
    click_on "Editar"
    fill_in "Nome fantasia",	with: "Buffet da Praça"
    fill_in "Razão social",	with: "Buffets LTDA"
    fill_in "CNPJ",	with:'21.543.312/0001-33'
    fill_in "Telefone de contato",	with: "00123456789"
    fill_in "E-mail de contato",	with: "atendimento@buffets.com"
    fill_in "Endereço",	with: "Rua Estrelas, 312"
    fill_in "Bairro",	with: "Sistema nao Solar" 
    fill_in "Cidade",	with: "Via queijo" 
    fill_in "Codigo do estado",	with: "XX"
    fill_in "CEP",	with: "99999-990" 
    uncheck "Dinheiro"
    fill_in "Descrição",	with: "Um buffet de outro mundo"
    click_on "Atualizar Buffet"

    expect(page).not_to have_content "Buffet atualizado com sucesso" 
    expect(page).to have_content "Erro ao atualizar Buffet"
    expect(page).to have_content  "Metodos de Pagamento não pode ficar em branco"
    
  end

  it "only if authenticated" do
    user = BuffetOwner.create!(email: 'r@fael.com', password: "password")
    buffet = Buffet.create!(brand_name: "Galaxy Buffet", corporate_name: "Buffetys LTDA", registration: "321.543.12/0001-33",
                            phone_number: "99123456789", email: "atendimento@buffyts.com", address: "Rua Estrelas, 123",
                            district: "Sistema Solar", city: "Via lactea", state_code: "AA", zip_code: "99999-999",
                            description: "Um buffet de outro mundo", buffet_owner: user)

    visit "/buffets/#{buffet.id}/edit"

    expect(current_path).not_to eq "/buffets/#{buffet.id}/edit"
    expect(page).to have_content "Para continuar, faça login ou registre-se."

  end

  it "only if authorized" do
    load_payments()
    user = BuffetOwner.create!(email: 'r@fael.com', password: "password")
    user_2 = BuffetOwner.create!(email: 'raf@el.com', password: "password")
    buffet = Buffet.create!(brand_name: "Galaxy Buffet", corporate_name: "Buffetys LTDA", registration: "321.543.12/0001-33",
                            phone_number: "99123456789", email: "atendimento@buffyts.com", address: "Rua Estrelas, 123",
                            district: "Sistema Solar", city: "Via lactea", state_code: "AA", zip_code: "99999-999",
                            description: "Um buffet de outro mundo", buffet_owner: user)
    Buffet.create!(brand_name: 'Volcano Buffets', corporate_name: 'Geological fissure LTDA', 
                  registration: '321.543.12/0001-32', phone_number: '99123456789', 
                  email: 'atendimento@lava.com', address: 'Rua explosion, 123',
                  district: 'underground', city: 'Tectonic rift', state_code: 'TT', 
                  zip_code: '99999-999', description: 'A blast of buffet', 
                  buffet_owner: user_2)
    BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find_by(method: "cash"))
    
    login_as user_2, scope: :buffet_owner
    visit "/buffets/#{buffet.id}/edit"

    expect(current_path).not_to eq "/buffets/#{buffet.id}/edit"
    expect(page).to have_content "Acesso não autorizado"

  end

end
