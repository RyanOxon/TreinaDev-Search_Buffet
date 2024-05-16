require 'rails_helper'

describe "buffet owner disable his buffet" do
  it "from buffet details" do
    user = BuffetOwner.create!(email: 'r@fael.com', password: 'password')
    buffet = Buffet.create!(brand_name: 'Rafael Buffet', corporate_name: 'Rafael Buffet LTDA', 
                            registration: '56673136000117', phone_number: '11999999999', 
                            email: 'rafael@buffet.com', address: 'Rua das Flores', 
                            district: 'Jardim das Flores', city: 'São Paulo', 
                            state_code: 'SP', zip_code: '09999999', description: 'O melhor buffet da região', 
                            buffet_owner: user)
    login_as user, scope: :buffet_owner

    visit buffet_path(buffet)

    expect(page).to have_button 'Desativar Buffet'
  end

  it "sucessfully" do
    user = BuffetOwner.create!(email: 'r@fael.com', password: 'password')
    buffet = Buffet.create!(brand_name: 'Rafael Buffet', corporate_name: 'Rafael Buffet LTDA', 
                            registration: '56673136000117', phone_number: '11999999999', 
                            email: 'rafael@buffet.com', address: 'Rua das Flores', 
                            district: 'Jardim das Flores', city: 'São Paulo', 
                            state_code: 'SP', zip_code: '09999999', description: 'O melhor buffet da região', 
                            buffet_owner: user)
    login_as user, scope: :buffet_owner

    visit buffet_path(buffet)
    click_on 'Desativar Buffet'

    expect(page).to have_content 'Buffet desativado com sucesso'
    expect(page).to have_content 'Reativar Buffet'
    expect(page).to have_content 'Rafael Buffet (Desativado)'

  end

  it "and a visitor can't see it in the list of buffets" do
    user = BuffetOwner.create!(email: 'r@fael.com', password: 'password')
    user_2 = BuffetOwner.create!(email: 'raf@el.com', password: 'password')
    Buffet.create!(brand_name: 'Rafael Buffet', corporate_name: 'Rafael Buffet LTDA', 
                            registration: '56673136000117', phone_number: '11999999999', 
                            email: 'rafael@buffet.com', address: 'Rua das Flores', 
                            district: 'Jardim das Flores', city: 'São Paulo', 
                            state_code: 'SP', zip_code: '09999999', description: 'O melhor buffet da região', 
                            buffet_owner: user, active: false)
    Buffet.create!(brand_name: 'Rafael 2 Buffet', corporate_name: 'Rafael2 Buffet LTDA', 
                            registration: '35918380000122', phone_number: '11999999999', 
                            email: 'rafael2@buffet.com', address: 'Rua das Flores', 
                            district: 'Jardim das Flores', city: 'São Paulo', 
                            state_code: 'SP', zip_code: '09999999', description: 'O segundo melhor buffet da região', 
                            buffet_owner: user_2)
                            
    visit root_path

    expect(page).to have_content 'Rafael 2 Buffet'
    expect(page).not_to have_content 'Rafael Buffet'
  end

  it "and cannot be searched" do
    user = BuffetOwner.create!(email: 'r@fael.com', password: 'password')
    user_2 = BuffetOwner.create!(email: 'raf@el.com', password: 'password')
    Buffet.create!(brand_name: 'Rafael Buffet', corporate_name: 'Rafael Buffet LTDA', 
                            registration: '35918380000122', phone_number: '11999999999', 
                            email: 'rafael@buffet.com', address: 'Rua das Flores', 
                            district: 'Jardim das Flores', city: 'São Paulo', 
                            state_code: 'SP', zip_code: '09999999', description: 'O melhor buffet da região', 
                            buffet_owner: user, active: false)
    Buffet.create!(brand_name: 'Rafael 2 Buffet', corporate_name: 'Rafael2 Buffet LTDA', 
                            registration: '56673136000117', phone_number: '11999999999', 
                            email: 'rafael2@buffet.com', address: 'Rua das Flores', 
                            district: 'Jardim das Flores', city: 'São Paulo', 
                            state_code: 'SP', zip_code: '09999999', description: 'O segundo melhor buffet da região', 
                            buffet_owner: user_2)
                            
    visit root_path
    fill_in 'Buscar Buffet',	with: 'Buffet' 
    click_on 'Buscar'

    expect(page).to have_content 'Resultados da Busca por: Buffet'
    expect(page).to have_content '1 buffet(s) encontrado(s)'
    expect(page).to have_content 'Rafael 2 Buffet'
    expect(page).not_to have_content 'Rafael Buffet'
    
  end

  it "and cannot be searched by exact name" do
    user = BuffetOwner.create!(email: 'r@fael.com', password: 'password')
    user_2 = BuffetOwner.create!(email: 'raf@el.com', password: 'password')
    Buffet.create!(brand_name: 'Rafael Buffet', corporate_name: 'Rafael Buffet LTDA', 
                            registration: '35918380000122', phone_number: '11999999999', 
                            email: 'rafael@buffet.com', address: 'Rua das Flores', 
                            district: 'Jardim das Flores', city: 'São Paulo', 
                            state_code: 'SP', zip_code: '09999999', description: 'O melhor buffet da região', 
                            buffet_owner: user, active: false)
    Buffet.create!(brand_name: 'Rafael 2 Buffet', corporate_name: 'Rafael2 Buffet LTDA', 
                            registration: '56673136000117', phone_number: '11999999999', 
                            email: 'rafael2@buffet.com', address: 'Rua das Flores', 
                            district: 'Jardim das Flores', city: 'São Paulo', 
                            state_code: 'SP', zip_code: '09999999', description: 'O segundo melhor buffet da região', 
                            buffet_owner: user_2)
                            
    visit root_path
    fill_in 'Buscar Buffet',	with: 'Rafael Buffet' 
    click_on 'Buscar'

    expect(page).to have_content 'Resultados da Busca por: Rafael Buffet' 
    expect(page).to have_content '0 buffet(s) encontrado(s)'
  end

  it "and cannot receive new orders" do
    load_categories
    user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
    buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                            registration: '56673136000117', phone_number: '9956673136000117', 
                            email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                            district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                            zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                            buffet_owner: user, active: false)
    event = Event.create!(name: 'Casamento Galaxy Buffet', description: 'um casamento muito louco',
                        min_capacity: 20, max_capacity: 40, default_duration: 240,
                        menu: 'um monte de comida', event_category: EventCategory.find_by(category: "wedding"),
                        exclusive_address: true, buffet: buffet)
    Event.create!(name: 'Corporativo Galaxy Buffet', description: 'Buffet para eventos corporativo',
                        min_capacity: 20, max_capacity: 40, default_duration: 240,
                        menu: 'Comida, comida, comida, comida, bebida, bebida', event_category: EventCategory.find_by(category: "corporate"),
                        exclusive_address: true, buffet: buffet)
    customer = Customer.create!(cpf: 33216336557, email: 'r@fael.com', password: 'password' )
    login_as customer, scope: :customer

    visit new_event_order_path(event)

    expect(current_path).not_to eq new_event_order_path(event)
    expect(page).to have_content "Não é possivel abrir novos pedidos para este buffet"

  end

  it "and can enable it again" do
    user = BuffetOwner.create!(email: 'r@fael.com', password: 'password')
    buffet = Buffet.create!(brand_name: 'Rafael Buffet', corporate_name: 'Rafael Buffet LTDA', 
                            registration: '56673136000117', phone_number: '11999999999', 
                            email: 'rafael@buffet.com', address: 'Rua das Flores', 
                            district: 'Jardim das Flores', city: 'São Paulo', 
                            state_code: 'SP', zip_code: '09999999', description: 'O melhor buffet da região', 
                            buffet_owner: user, active: false)
    login_as user, scope: :buffet_owner

    visit buffet_path(buffet)
    click_on "Reativar Buffet"

    expect(page).to have_content "Buffet reativado com sucesso"
    expect(page).to have_button "Desativar Buffet"
    expect(page).not_to have_content "(Desativado)"
  end
end
