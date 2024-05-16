require 'rails_helper'

describe "requests for event" do
  context "#update" do
    it "and its not the owner" do
      load_payments
      load_features
      load_categories
      user = BuffetOwner.create!(email: 'raf@el.com', password: 'password')
      user_2 = BuffetOwner.create!(email: 'r@fael.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '22300696000104', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      BuffetPaymentMethod.create!(buffet: buffet, payment_method: PaymentMethod.find_by(method: "credit_card"))
      Buffet.create!(brand_name: 'Volcano Buffets', corporate_name: 'Geological fissure LTDA', 
                              registration: '35918380000122', phone_number: '99123456789', 
                              email: 'atendimento@lava.com', address: 'Rua explosion, 123',
                              district: 'underground', city: 'Tectonic rift', state_code: 'TT', 
                              zip_code: '99999-999', description: 'A blast of buffet', 
                              buffet_owner: user_2)
      event = Event.create!(name: 'Casamento Galaxy Buffet', description: 'um casamento muito louco',
                          min_capacity: 20, max_capacity: 40, default_duration: 240,
                          menu: 'um monte de comida', event_category: EventCategory.find_by(category: "wedding"),
                          exclusive_address: true, buffet: buffet)
      EventFeature.create!(event: event, feature: Feature.find_by(feature: "alcohol"))

      login_as user_2, scope: :buffet_owner

      patch event_path(event.id), params: {event: {name: 'casamento editado'}}
      
      expect(response).to redirect_to user_2.buffet

    end
    
  end
  
  context "#cover" do
    it "cover_id must be related to the event" do
      load_categories
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      user_2 = BuffetOwner.create!(email: 'r@fael.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '12742045000110', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      buffet_2 = Buffet.create!(brand_name: 'Volcano Buffets', corporate_name: 'Geological fissure LTDA', 
                              registration: '07438436000106', phone_number: '99123456789', 
                              email: 'atendimento@lava.com', address: 'Rua explosion, 123',
                              district: 'underground', city: 'Tectonic rift', state_code: 'TT', 
                              zip_code: '99999-999', description: 'A blast of buffet', 
                              buffet_owner: user_2)
      event = Event.create!(name: 'Eventinho', description: 'um evento muito louco',
                            min_capacity: 20, max_capacity: 40, default_duration: 240,
                            menu: 'um monte de comida', event_category: EventCategory.find_by(category: "debutante_ball"),
                            exclusive_address: true, buffet: buffet)
      event_2 = Event.create!(name: 'Eventinho 2', description: 'um outro evento muito louco',
                            min_capacity: 20, max_capacity: 40, default_duration: 240,
                            menu: 'um monte de comida denovo', event_category: EventCategory.find_by(category: "debutante_ball"),
                            exclusive_address: true, buffet: buffet_2)
      HolderImage.create!(image: fixture_file_upload(Rails.root.join('spec', 'support', 'image.jpg')), user: user, holder: event)
      HolderImage.create!(image: fixture_file_upload(Rails.root.join('spec', 'support', 'image.jpg')), user: user_2, holder: event_2)

      post cover_event_path(event_2.id), params: {cover_id: event.holder_images.first.id}
      follow_redirect!
      expect(controller.flash[:alert]).to eq 'Imagem não encontrada' 
    end
  end

  context "#index" do
    it "must be authenticated" do
      get events_path

      expect(response).to redirect_to root_path 
    end

    it "only buffet owner" do
      customer = Customer.create!(cpf: 33216336557, email: 'r@fael.com', password: 'password' )
      login_as customer, scope: :customer
      
      get events_path

      expect(response).to redirect_to root_path 
    end
    
  end
end
