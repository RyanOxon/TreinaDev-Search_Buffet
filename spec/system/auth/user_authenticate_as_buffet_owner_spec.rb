require 'rails_helper'

describe "user authenticate as buffet owner" do
  context "Sign up" do
    it "from root path" do
      visit root_path
      within 'div#owners' do
        click_on 'Registrar-se'
      end

      expect(page).to have_field 'E-mail'
      expect(page).to have_field 'Senha'
      expect(page).to have_field 'Confirme sua senha'
      
    end
    
    it "sucessfully" do
      visit root_path
      within 'div#owners' do
        click_on 'Registrar-se'
      end
      fill_in "E-mail",	with: "rafa@el.com"
      fill_in "Senha",	with: "password"
      fill_in "Confirme sua senha",	with: "password" 
      click_on "Criar conta"

      expect(page).to have_content "Bem vindo! Você realizou seu registro com sucesso."
      expect(page).to have_content "Dono de Buffet: rafa@el.com"
      expect(page).to have_content "Sair"
    end

    it "and Logout" do
      visit root_path
      within 'div#owners' do
        click_on 'Registrar-se'
      end
      fill_in "E-mail",	with: "rafa@el.com"
      fill_in "Senha",	with: "password"
      fill_in "Confirme sua senha",	with: "password" 
      click_on "Criar conta"
      click_on "Sair"

      expect(page).to have_content "Logout efetuado com sucesso."
      expect(page).to have_content "Logar"
      expect(page).to have_content "Para empresas"
      
    end

    it "with missing params" do
      visit root_path
      within 'div#owners' do
        click_on 'Registrar-se'
      end
      fill_in "E-mail",	with: ""
      fill_in "Senha",	with: ""
      fill_in "Confirme sua senha",	with: "" 
      click_on "Criar conta"

      expect(page).to have_content "Não foi possível salvar dono de buffet"
      expect(page).to have_content "E-mail não pode ficar em branco"
      expect(page).to have_content "Senha não pode ficar em branco"
    end
    
    it "and email is already taken" do
      BuffetOwner.create!(email: "rafa@el.com", password: "password")

      visit root_path
      within 'div#owners' do
        click_on 'Registrar-se'
      end
      fill_in "E-mail",	with: "rafa@el.com"
      fill_in "Senha",	with: "password"
      fill_in "Confirme sua senha",	with: "password" 
      click_on "Criar conta"
      
      expect(page).to have_content "Não foi possível salvar dono de buffet"
      expect(page).to have_content "E-mail já está em uso"
    end
  end
     
  context "Sign in" do
    it "from root path" do
      visit root_path
      within 'div#owners' do
        click_on 'Logar'
      end

      expect(page).to have_field 'E-mail'
      expect(page).to have_field 'Senha'
    end
    
    it "Sucessfully" do
      BuffetOwner.create!(email: 'rafa@el.com', password: "password")
      visit root_path

      within 'div#owners' do
        click_on "Logar"
      end

      fill_in "E-mail",	with: "rafa@el.com"
      fill_in "Senha",	with: "password"
      click_on "Log in"

      expect(page).to have_content "Dono de Buffet: rafa@el.com"
      expect(page).to have_content "Sair"
      expect(page).not_to have_content "Para empresas" 
    end
  end
  
end
