require 'rails_helper'

RSpec.describe Event, type: :model do
  context "#valid?" do
    it "false when name is empty" do
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '07267705000119', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      EventCategory.create!(category: "wedding")
      event = Event.new( description: 'um evento muito louco',
                              min_capacity: 20, max_capacity: 40, default_duration: 240,
                              menu: 'um monte de comida', event_category: EventCategory.find_by(category: "wedding"),
                              exclusive_address: true, buffet: buffet)

      expect(event.valid?).to be_falsey
    end
    it "false when description is empty" do
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '07267705000119', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      EventCategory.create!(category: "wedding")
      event = Event.new(name: 'Eventinho', 
                              min_capacity: 20, max_capacity: 40, default_duration: 240,
                              menu: 'um monte de comida', event_category: EventCategory.find_by(category: "wedding"),
                              exclusive_address: true, buffet: buffet)

      expect(event.valid?).to be_falsey
      
    end
    it "false when min_capacity is empty" do
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '07267705000119', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      EventCategory.create!(category: "wedding")
      event = Event.new(name: 'Eventinho', description: 'um evento muito louco',
                              max_capacity: 40, default_duration: 240,
                              menu: 'um monte de comida', event_category: EventCategory.find_by(category: "wedding"),
                              exclusive_address: true, buffet: buffet)

      expect(event.valid?).to be_falsey
      
    end
    it "false when max_capacity is empty" do
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '07267705000119', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      EventCategory.create!(category: "wedding")
      event = Event.new(name: 'Eventinho', description: 'um evento muito louco',
                              min_capacity: 20, default_duration: 240,
                              menu: 'um monte de comida', event_category: EventCategory.find_by(category: "wedding"),
                              exclusive_address: true, buffet: buffet)

      expect(event.valid?).to be_falsey
      
    end
    it "false when default_duration is empty" do
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '07267705000119', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      EventCategory.create!(category: "wedding")
      event = Event.new(name: 'Eventinho', description: 'um evento muito louco',
                              min_capacity: 20, max_capacity: 40,
                              menu: 'um monte de comida', event_category: EventCategory.find_by(category: "wedding"),
                              exclusive_address: true, buffet: buffet)

      expect(event.valid?).to be_falsey
      
    end
    it "false when menu is empty" do
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '07267705000119', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      EventCategory.create!(category: "wedding")
      event = Event.new(name: 'Eventinho', description: 'um evento muito louco',
                              min_capacity: 20, max_capacity: 40, default_duration: 240,
                              event_category: EventCategory.find_by(category: "wedding"),
                              exclusive_address: true, buffet: buffet)

      expect(event.valid?).to be_falsey
      
    end

    it "false when name is not unique" do
      user = BuffetOwner.create!(email: 'rafa@el.com', password: 'password')
      buffet = Buffet.create!(brand_name: 'Galaxy Buffet', corporate_name: 'Buffetys LTDA', 
                              registration: '07267705000119', phone_number: '99123456789', 
                              email: 'atendimento@buffyts.com', address: 'Rua Estrelas, 123',
                              district: 'Sistema Solar', city: 'Via lactea', state_code: 'AA', 
                              zip_code: '99999-999', description: 'Um buffet de outro mundo', 
                              buffet_owner: user)
      EventCategory.create!(category: "wedding")
      Event.create!(name: 'Eventinho', description: 'um evento muito louco',
                              min_capacity: 20, max_capacity: 40, default_duration: 240,
                              menu: 'um monte de comida', event_category: EventCategory.find_by(category: "wedding"),
                              exclusive_address: true, buffet: buffet)
      event = Event.new(name: 'Eventinho', description: 'outro evento muito louco',
                              min_capacity: 20, max_capacity: 40, default_duration: 240,
                              menu: 'um monte de comida', event_category: EventCategory.find_by(category: "wedding"),
                              exclusive_address: true, buffet: buffet)


      expect(event.valid?).to be_falsey
      
    end
  end
end
