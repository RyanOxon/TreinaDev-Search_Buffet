require 'rails_helper'

describe "buffet Owner register buffet" do
  it "sucessfully" do
    user = BuffetOwner.create!(email: 'rafa@el.com', password: "password")
    load_payments()
    
    login_as user
    visit root_path
    click_on "Meu Buffet"

    fill_in "Nome fantasia",	with: "Buffet da Praça"
    fill_in "Razão social",	with: "Buffetys LTDA"
    fill_in "CNPJ",	with: "321.543.12/0001-33" 
    fill_in "Telefone de contato",	with: "99123456789"
    fill_in "E-mail de contato",	with: "atendimento@buffyts.com"
    check "Dinheiro"
    fill_in "Descrição",	with: "Empresa de buffet criado em 2000"

    expect(page).to have_content "Buffet cadastrado com sucesso" 

  end

  it "and is forced to create" do
    user = BuffetOwner.create!(email: 'rafa@el.com', password: "password")
    
    login_as user
    visit root_path
    click_on "Cade Buffet?"

    expect(page).to have_content "É necessario ter um buffet cadastrado para continuar"
    expect(current_path).to eq new_buffet_path 
  end
  
  
end
