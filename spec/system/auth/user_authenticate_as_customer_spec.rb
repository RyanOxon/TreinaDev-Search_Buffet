require 'rails_helper'

describe 'user authenticate as customer' do
  context 'Sign up' do
    it 'from root path' do
      visit root_path
      within 'div#customers' do
        click_on 'Registrar-se'
      end

      expect(page).to have_field 'CPF'
      expect(page).to have_field 'E-mail'
      expect(page).to have_field 'Senha'
      expect(page).to have_field 'Confirme sua senha'
      
    end

    it 'sucessfully' do
      visit root_path
      within 'div#customers' do
        click_on 'Registrar-se'
      end
      fill_in 'CPF',	with: '33216336557' 
      fill_in 'E-mail',	with: 'rafa@el.com'
      fill_in 'Senha',	with: 'password'
      fill_in 'Confirme sua senha',	with: 'password' 
      click_on 'Criar conta'

      expect(page).to have_content 'Bem vindo! Você realizou seu registro com sucesso.'
      expect(Customer.last.cpf).to eq '33216336557' 
      expect(page).to have_content 'Usuario: rafa@el.com'
      expect(page).to have_content 'Sair'
    end

    it "with invalid cpf" do
      visit root_path
      within 'div#customers' do
        click_on 'Registrar-se'
      end
      fill_in 'CPF',	with: '34567890123' 
      fill_in 'E-mail',	with: 'rafa@el.com'
      fill_in 'Senha',	with: 'password'
      fill_in 'Confirme sua senha',	with: 'password' 
      click_on 'Criar conta'

      expect(page).not_to have_content 'Bem vindo! Você realizou seu registro com sucesso.'
      expect(page).to have_content 'Não foi possível salvar cliente'
      expect(page).to have_content 'CPF não é valido'
      
    end
    

  end

  context 'Sign in' do
     xit "customer login" do
      
     end
  end
end
