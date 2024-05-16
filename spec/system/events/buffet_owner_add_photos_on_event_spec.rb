require 'rails_helper'

describe "buffet owner add photos on a event" do
  it "from event details" do
    load_categories
    user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
    buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                            registration: '74107306000188', phone_number: '99123456789', 
                            email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                            district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                            zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                            buffet_owner: user)
    Event.create!(name: 'Eventinho', description: 'um evento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find_by(category: "debutante_ball"),
                          exclusive_address: true, buffet: buffet)

    login_as user, scope: :buffet_owner

    visit root_path
    click_on 'Eventinho'

    expect(page).to have_content 'Galeria de Imagens'
    expect(page).to have_content 'Escolha um arquivo…'
    expect(page).to have_content 'Nenhum arquivo selecionado'
    expect(page).to have_field 'file-input'
    expect(page).to have_button 'Salvar Imagem'
                          
  end
  
  it "sucessfully" do
    load_categories
    user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
    buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                            registration: '74107306000188', phone_number: '99123456789', 
                            email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                            district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                            zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                            buffet_owner: user)
    event = Event.create!(name: 'Eventinho', description: 'um evento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find_by(category: "debutante_ball"),
                          exclusive_address: true, buffet: buffet)

    login_as user, scope: :buffet_owner

    visit root_path
    click_on 'Eventinho'

    attach_file 'file-input', Rails.root.join('spec', 'support', 'image.jpg')
    click_on 'Salvar Imagem'

    expect(current_path).to eq event_path(event.id)
    expect(page).to have_content 'Imagem anexada com sucesso'
    expect(page).to have_css'img[src*="image.jpg"]'
    
  end

  it "with no image" do
    load_categories
    user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
    buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                            registration: '74107306000188', phone_number: '99123456789', 
                            email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                            district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                            zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                            buffet_owner: user)
    Event.create!(name: 'Eventinho', description: 'um evento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find_by(category: "debutante_ball"),
                          exclusive_address: true, buffet: buffet)

    login_as user, scope: :buffet_owner

    visit root_path
    click_on 'Eventinho'
    click_on 'Salvar Imagem'

    expect(page).to have_content 'Erro ao anexar imagem'
    
  end

  it "and set a photo as cover" do
    load_categories
    user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
    buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                            registration: '74107306000188', phone_number: '99123456789', 
                            email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                            district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                            zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                            buffet_owner: user)
    event = Event.create!(name: 'Eventinho', description: 'um evento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find_by(category: "debutante_ball"),
                          exclusive_address: true, buffet: buffet)
    HolderImage.create!(image: fixture_file_upload(Rails.root.join('spec', 'support', 'image.jpg')), user: user, holder: event)

    login_as user, scope: :buffet_owner
    visit root_path
    click_on 'Eventinho'

    within "div.box-#{event.holder_images.first.id}" do
      click_on 'Definir como capa'
    end

    expect(page).to have_content 'Capa atualizada com sucesso'
    within "div.box-#{event.holder_images.first.id}" do
      expect(page).to have_content 'Capa atual'
    end
  end

  it "only as buffet_owner" do
    load_categories
    user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
    buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                            registration: '74107306000188', phone_number: '99123456789', 
                            email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                            district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                            zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                            buffet_owner: user)
    event = Event.create!(name: 'Eventinho', description: 'um evento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find_by(category: "debutante_ball"),
                          exclusive_address: true, buffet: buffet)
    HolderImage.create!(image: fixture_file_upload(Rails.root.join('spec', 'support', 'image.jpg')), user: user, holder: event)

    visit root_path
    click_on 'Galaxy Buffet'
    click_on 'Eventinho'

    expect(page).to have_content 'Galeria de Imagens'
    expect(page).to have_css('img[src*="image.jpg"]')
    expect(page).not_to have_content 'Escolha um arquivo…'
    expect(page).not_to have_content 'Nenhum arquivo selecionado'
    expect(page).not_to have_field 'file-input'
    expect(page).not_to have_button 'Salvar Imagem'
    expect(page).not_to have_button 'Definir como capa' 
  end
end
