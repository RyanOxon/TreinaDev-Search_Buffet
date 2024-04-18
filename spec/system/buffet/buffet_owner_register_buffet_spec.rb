require 'rails_helper'

describe "buffet Owner register buffet" do
  it "sucessfully" do
    user = BuffetOwner.create!(email: 'rafa@el.com', password: "password")
    
    login_as user
    visit root_path
    click_on "Meu Buffet"

    fill_in "Nome Fantasia:",	with: "Buffet da Praça"
    fill_in "Razão Social",	with: "Buffetys LTDA"
    fill_in "CNPJ",	with: "321.543.12/0001-33" 
    fill_in "Telefone de Contato",	with: "99123456789"
    fill_in "E-mail de Contato",	with: "atendimento@buffyts.com"
    check "Dinheiro"
    check "Pix"
    check "Cheque"
    fill_in "description",	with: "Empresa de buffet criado em 2000"

    expect(page).to have_content "Buffet cadastrado com sucesso" 

  end
  
end
