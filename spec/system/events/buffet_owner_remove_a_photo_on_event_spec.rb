require 'rails_helper'

describe "buffet owner removes a photo on event" do
  it "from event details" do
    load_categories
    user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
    buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                            registration: '321.543.12/0001-33', phone_number: '99123456789', 
                            email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                            district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                            zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                            buffet_owner: user)
    event = Event.create!(name: 'Eventinho', description: 'um evento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find_by(category: "debutante_ball"),
                          exclusive_address: true, buffet: buffet)
    HolderImage.create!(image: fixture_file_upload(Rails.root.join('spec', 'support', 'casamento.jpg')), user: user, holder: event)

    login_as user, scope: :buffet_owner
    visit root_path
    click_on 'Eventinho'

    within "div.box-#{event.holder_images.first.id}" do
      expect(page).to have_button 'Remover' 
    end
    
  end

  it "sucessfully" do
    load_categories
    user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
    buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                            registration: '321.543.12/0001-33', phone_number: '99123456789', 
                            email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                            district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                            zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                            buffet_owner: user)
    event = Event.create!(name: 'Eventinho', description: 'um evento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find_by(category: "debutante_ball"),
                          exclusive_address: true, buffet: buffet)
    HolderImage.create!(image: fixture_file_upload(Rails.root.join('spec', 'support', 'casamento.jpg')), user: user, holder: event)

    login_as user, scope: :buffet_owner
    visit root_path
    click_on 'Eventinho'

    within "div.box-#{event.holder_images.first.id}" do
      click_on 'Remover'
    end

    expect(page).to have_content "Imagem removida com sucesso"
    expect(page).not_to have_css('img[src*="casamento.jpg"]')
    
  end

  it "only as buffet_owner" do
    load_categories
    user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
    buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                            registration: '321.543.12/0001-33', phone_number: '99123456789', 
                            email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                            district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                            zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                            buffet_owner: user)
    event = Event.create!(name: 'Eventinho', description: 'um evento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find_by(category: "debutante_ball"),
                          exclusive_address: true, buffet: buffet)
    HolderImage.create!(image: fixture_file_upload(Rails.root.join('spec', 'support', 'casamento.jpg')), user: user, holder: event)

    visit root_path
    click_on 'Galaxy Buffet'
    click_on 'Eventinho'

    expect(page).to have_content 'Galeria de Imagens'
    expect(page).to have_css('img[src*="casamento.jpg"]')
    expect(page).not_to have_button 'Remover'
  end
end
