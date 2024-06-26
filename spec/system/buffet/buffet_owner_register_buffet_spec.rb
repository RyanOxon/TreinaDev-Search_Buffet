require 'rails_helper'

describe "buffet Owner register buffet" do
  it "after sign up" do
    visit root_path
      within 'div#owners' do
        click_on 'Registrar-se'
      end
      fill_in "E-mail",	with: "rafa@el.com"
      fill_in "Senha",	with: "password"
      fill_in "Confirme sua senha",	with: "password" 
      click_on "Criar conta"

      expect(page).to have_field 'Nome fantasia'
      expect(page).to have_field 'Razão social'
      expect(page).to have_field 'CNPJ'
      expect(page).to have_field 'Telefone de contato'
      expect(page).to have_field 'E-mail de contato'
      expect(page).to have_field 'Endereço'
      expect(page).to have_field 'Bairro'
      expect(page).to have_field 'Cidade'
      expect(page).to have_field 'Codigo do estado'
      expect(page).to have_field 'CEP'
      expect(page).to have_content 'Metodos de Pagamento'
    
  end

  it "after log in while still dont have one" do
    BuffetOwner.create!(email: 'rafa@el.com', password: "password")

    visit root_path
    within 'div#owners' do
      click_on 'Logar'
    end
    fill_in "E-mail",	with: "rafa@el.com"
    fill_in "Senha",	with: "password"
    click_on 'Log in'


    expect(page).to have_field 'Nome fantasia'
    expect(page).to have_field 'Razão social'
    expect(page).to have_field 'CNPJ'
    expect(page).to have_field 'Telefone de contato'
    expect(page).to have_field 'E-mail de contato'
    expect(page).to have_field 'Endereço'
    expect(page).to have_field 'Bairro'
    expect(page).to have_field 'Cidade'
    expect(page).to have_field 'Codigo do estado'
    expect(page).to have_field 'CEP'
    expect(page).to have_content 'Metodos de Pagamento'

  end

  it "sucessfully" do
    user = BuffetOwner.create!(email: 'rafa@el.com', password: "password")
    load_payments()
    login_as user, scope: :buffet_owner

    visit root_path
    click_on "Meu Buffet"

    fill_in "Nome fantasia",	with: "Buffet da Praça"
    fill_in "Razão social",	with: "Buffetys LTDA"
    fill_in "CNPJ",	with: "35918380000122" 
    fill_in "Telefone de contato",	with: "99123456789"
    fill_in "E-mail de contato",	with: "atendimento@buffyts.com"
    fill_in "Endereço",	with: "Rua Estrelas, 123"
    fill_in "Bairro",	with: "Sistema Solar" 
    fill_in "Cidade",	with: "Via lactea" 
    fill_in "Codigo do estado",	with: "AA"
    fill_in "CEP",	with: "99999-999" 
    check "Dinheiro"
    fill_in "Descrição",	with: "Um buffet de outro mundo"
    click_on "Criar Buffet"

    expect(page).to have_content "Buffet cadastrado com sucesso" 
    expect(page).to have_content "Buffet da Praça"
    expect(page).to have_content "Buffetys LTDA"
    expect(page).to have_content "35918380000122"
    expect(page).to have_content "99123456789"
    expect(page).to have_content "atendimento@buffyts.com"
    expect(page).to have_content "Rua Estrelas, 123"
    expect(page).to have_content "Via lactea"
    expect(page).to have_content "AA"
    expect(page).to have_content "99999-999"
    expect(page).to have_content "Um buffet de outro mundo"
    expect(page).to have_content "Dinheiro"

  end

  it "and is forced to create" do
    user = BuffetOwner.create!(email: 'rafa@el.com', password: "password")
    login_as user, scope: :buffet_owner

    visit root_path
    click_on "Cade Buffet?"

    expect(page).to have_content "É necessario ter um buffet cadastrado para continuar"
    expect(current_path).to eq new_buffet_path 
  end

  it "with incomplete informations" do
    load_payments()
    user = BuffetOwner.create!(email: 'rafa@el.com', password: "password")
    login_as user, scope: :buffet_owner

    visit root_path
    click_on "Meu Buffet"
    fill_in "Nome fantasia",	with: ""
    fill_in "Razão social",	with: "Buffetys LTDA"
    fill_in "CNPJ",	with: "321.543.12/0001-33" 
    fill_in "Telefone de contato",	with: "99123456789"
    fill_in "E-mail de contato",	with: "atendimento@buffyts.com"
    fill_in "Endereço",	with: "Rua Estrelas, 123"
    fill_in "Bairro",	with: "Sistema Solar" 
    fill_in "Cidade",	with: "Via lactea" 
    fill_in "Codigo do estado",	with: "AA"
    fill_in "CEP",	with: "99999-999" 
    check "Dinheiro"
    fill_in "Descrição",	with: "Um buffet de outro mundo"
    click_on "Criar Buffet"

    expect(page).not_to have_content "Buffet cadastrado com sucesso" 
    expect(page).to have_content "Erro ao cadastrar Buffet"
    expect(page).to have_content "Nome fantasia não pode ficar em branco"
  end

  it "without payment methods" do
    user = BuffetOwner.create!(email: 'rafa@el.com', password: "password")
    load_payments()
    login_as user, scope: :buffet_owner

    visit root_path
    click_on "Meu Buffet"
    fill_in "Nome fantasia",	with: "Buffet Galatico"
    fill_in "Razão social",	with: "Buffetys LTDA"
    fill_in "CNPJ",	with: "321.543.12/0001-33" 
    fill_in "Telefone de contato",	with: "99123456789"
    fill_in "E-mail de contato",	with: "atendimento@buffyts.com"
    fill_in "Endereço",	with: "Rua Estrelas, 123"
    fill_in "Bairro",	with: "Sistema Solar" 
    fill_in "Cidade",	with: "Via lactea" 
    fill_in "Codigo do estado",	with: "AA"
    fill_in "CEP",	with: "99999-999" 
    fill_in "Descrição",	with: "Um buffet de outro mundo"
    click_on "Criar Buffet"

    expect(page).not_to have_content "Buffet cadastrado com sucesso" 
    expect(page).to have_content "Erro ao cadastrar Buffet"
    expect(page).to have_content "Metodos de Pagamento não pode ficar em branco"
  end

  it "and is not sign in" do

    visit new_buffet_path
    
    expect(page).to have_content "Para continuar, faça login ou registre-se."
  end
  
  it "state code has to be 2 digits" do
    user = BuffetOwner.create!(email: 'rafa@el.com', password: "password")
    load_payments()
    login_as user, scope: :buffet_owner

    visit root_path
    click_on "Meu Buffet"
    fill_in "Nome fantasia",	with: "Buffet Galatico"
    fill_in "Razão social",	with: "Buffetys LTDA"
    fill_in "CNPJ",	with: "321.543.12/0001-33" 
    fill_in "Telefone de contato",	with: "99123456789"
    fill_in "E-mail de contato",	with: "atendimento@buffyts.com"
    fill_in "Endereço",	with: "Rua Estrelas, 123"
    fill_in "Bairro",	with: "Sistema Solar" 
    fill_in "Cidade",	with: "Via lactea" 
    fill_in "Codigo do estado",	with: "AAAA"
    fill_in "CEP",	with: "99999-999" 
    fill_in "Descrição",	with: "Um buffet de outro mundo"
    check 'Dinheiro'
    click_on "Criar Buffet"

    expect(page).not_to have_content "Buffet cadastrado com sucesso" 
    expect(page).to have_content "Erro ao cadastrar Buffet"
    expect(page).to have_content "Codigo do estado não possui o tamanho esperado"
    
  end

  it "only if authenticated" do

    visit '/buffets/new'

    expect(current_path).not_to eq '/buffets/new'
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

  it "and already have a buffet registered" do
    user = BuffetOwner.create!(email: 'r@fael.com', password: "password")
    Buffet.create!(brand_name: "Galaxy Buffet", corporate_name: "Buffetys LTDA", registration: "35918380000122",
                            phone_number: "99123456789", email: "atendimento@buffyts.com", address: "Rua Estrelas, 123",
                            district: "Sistema Solar", city: "Via lactea", state_code: "AA", zip_code: "99999-999",
                            description: "Um buffet de outro mundo", buffet_owner: user)
    
    login_as user, scope: :buffet_owner

    visit '/buffets/new'

    expect(current_path).not_to eq '/buffets/new'
    expect(page).to have_content 'Voce ja possui um buffet'

  end
  
end
