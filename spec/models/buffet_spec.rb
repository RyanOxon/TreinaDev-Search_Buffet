require 'rails_helper'

RSpec.describe Buffet, type: :model do
  describe "#valid?" do
    it "false when brand name is empty" do
      owner = BuffetOwner.create!(email: "A@A", password: "password")
      buffet = Buffet.new(brand_name: "", corporate_name: "Buffetys LTDA", registration: "56673136000117",
                          phone_number: "99123456789", email: "atendimento@buffyts.com", address: "Rua Estrelas, 123",
                          district: "Sistema Solar", city: "Via lactea", state_code: "AA", zip_code: "99999-999",
                          description: "Um buffet de outro mundo", buffet_owner: owner)
      
      expect(buffet.valid?).to be_falsey
    end
    it "false when corporate name is empty" do
      owner = BuffetOwner.create!(email: "A@A", password: "password")
      buffet = Buffet.new(brand_name: "Buffet Galatico", corporate_name: "", registration: "56673136000117",
                          phone_number: "99123456789", email: "atendimento@buffyts.com", address: "Rua Estrelas, 123",
                          district: "Sistema Solar", city: "Via lactea", state_code: "AA", zip_code: "99999-999",
                          description: "Um buffet de outro mundo", buffet_owner: owner)
      
      expect(buffet.valid?).to be_falsey
    end
    it "false when registration is empty" do
      owner = BuffetOwner.create!(email: "A@A", password: "password")
      buffet = Buffet.new(brand_name: "Buffet Galatico", corporate_name: "Buffetys LTDA", registration: "",
                          phone_number: "99123456789", email: "atendimento@buffyts.com", address: "Rua Estrelas, 123",
                          district: "Sistema Solar", city: "Via lactea", state_code: "AA", zip_code: "99999-999",
                          description: "Um buffet de outro mundo", buffet_owner: owner )
      
      expect(buffet.valid?).to be_falsey
    end
    it "false when phone number is empty" do
      owner = BuffetOwner.create!(email: "A@A", password: "password")
      buffet = Buffet.new(brand_name: "Buffet Galatico", corporate_name: "Buffetys LTDA", registration: "56673136000117",
                          phone_number: "", email: "atendimento@buffyts.com", address: "Rua Estrelas, 123",
                          district: "Sistema Solar", city: "Via lactea", state_code: "AA", zip_code: "99999-999",
                          description: "Um buffet de outro mundo", buffet_owner: owner )
      
      expect(buffet.valid?).to be_falsey
    end
    it "false when email is empty" do
      owner = BuffetOwner.create!(email: "A@A", password: "password")
      buffet = Buffet.new(brand_name: "Buffet Galatico", corporate_name: "Buffetys LTDA", registration: "56673136000117",
                          phone_number: "99123456789", email: "", address: "Rua Estrelas, 123",
                          district: "Sistema Solar", city: "Via lactea", state_code: "AA", zip_code: "99999-999",
                          description: "Um buffet de outro mundo", buffet_owner: owner )
      
      expect(buffet.valid?).to be_falsey
    end
    it "false when address is empty" do
      owner = BuffetOwner.create!(email: "A@A", password: "password")
      buffet = Buffet.new(brand_name: "Buffet Galatico", corporate_name: "Buffetys LTDA", registration: "56673136000117",
                          phone_number: "99123456789", email: "atendimento@buffyts.com", address: "",
                          district: "Sistema Solar", city: "Via lactea", state_code: "AA", zip_code: "99999-999",
                          description: "Um buffet de outro mundo", buffet_owner: owner )
      
      expect(buffet.valid?).to be_falsey
    end
    it "false when district is empty" do
      owner = BuffetOwner.create!(email: "A@A", password: "password")
      buffet = Buffet.new(brand_name: "Buffet Galatico", corporate_name: "Buffetys LTDA", registration: "56673136000117",
                          phone_number: "99123456789", email: "atendimento@buffyts.com", address: "Rua Estrelas, 123",
                          district: "", city: "Via lactea", state_code: "AA", zip_code: "99999-999",
                          description: "Um buffet de outro mundo", buffet_owner: owner )
      
      expect(buffet.valid?).to be_falsey
    end
    it "false when city is empty" do
      owner = BuffetOwner.create!(email: "A@A", password: "password")
      buffet = Buffet.new(brand_name: "Buffet Galatico", corporate_name: "Buffetys LTDA", registration: "56673136000117",
                          phone_number: "99123456789", email: "atendimento@buffyts.com", address: "Rua Estrelas, 123",
                          district: "Sistema Solar", city: "", state_code: "AA", zip_code: "99999-999",
                          description: "Um buffet de outro mundo", buffet_owner: owner )
      
      expect(buffet.valid?).to be_falsey
    end
    it "false when state_code is empty" do
      owner = BuffetOwner.create!(email: "A@A", password: "password")
      buffet = Buffet.new(brand_name: "Buffet Galatico", corporate_name: "Buffetys LTDA", registration: "56673136000117",
                          phone_number: "99123456789", email: "atendimento@buffyts.com", address: "Rua Estrelas, 123",
                          district: "Sistema Solar", city: "Via lactea", state_code: "", zip_code: "99999-999",
                          description: "Um buffet de outro mundo", buffet_owner: owner )
      
      expect(buffet.valid?).to be_falsey
    end
    it "false when zip code is empty" do
      owner = BuffetOwner.create!(email: "A@A", password: "password")
      buffet = Buffet.new(brand_name: "Buffet Galatico", corporate_name: "Buffetys LTDA", registration: "56673136000117",
                          phone_number: "99123456789", email: "atendimento@buffyts.com", address: "Rua Estrelas, 123",
                          district: "Sistema Solar", city: "Via lactea", state_code: "AA", zip_code: "",
                          description: "Um buffet de outro mundo", buffet_owner: owner )
      
      expect(buffet.valid?).to be_falsey
    end
    it "false when description is empty" do
      owner = BuffetOwner.create!(email: "A@A", password: "password")
      buffet = Buffet.new(brand_name: "Buffet Galatico", corporate_name: "Buffetys LTDA", registration: "56673136000117",
                          phone_number: "99123456789", email: "atendimento@buffyts.com", address: "Rua Estrelas, 123",
                          district: "Sistema Solar", city: "Via lactea", state_code: "AA", zip_code: "99999-999",
                          description: "", buffet_owner: owner )
      
      expect(buffet.valid?).to be_falsey
    end

    it "false when brand_name not unique" do
      owner = BuffetOwner.create!(email: "A@AA", password: "password")
      owner_1 = BuffetOwner.create!(email: "A@A", password: "password")
      Buffet.create!(brand_name: "Buffet Galatico", corporate_name: "Buffetys LTDAA", registration: "56673136000117",
                          phone_number: "99123456789", email: "atendimento@buffyts.com", address: "Rua Estrelas, 123",
                          district: "Sistema Solar", city: "Via lactea", state_code: "AA", zip_code: "99999-999",
                          description: "blablabla", buffet_owner: owner )

      buffet = Buffet.new(brand_name: "Buffet Galatico", corporate_name: "Buffetys LTDA", registration: "56673136000117",
                          phone_number: "99123456789", email: "atendimento@buffyts.com", address: "Rua Estrelas, 123",
                          district: "Sistema Solar", city: "Via lactea", state_code: "AA", zip_code: "99999-999",
                          description: "blablabla", buffet_owner: owner_1 )
      
      expect(buffet.valid?).to be_falsey
      
    end

    it "false when corpo_name not unique" do
      owner = BuffetOwner.create!(email: "A@AA", password: "password")
      owner_1 = BuffetOwner.create!(email: "A@A", password: "password")
      Buffet.create!(brand_name: "Buffet Galaticoo", corporate_name: "Buffetys LTDA", registration: "56673136000117",
                          phone_number: "99123456789", email: "atendimento@buffyts.com", address: "Rua Estrelas, 123",
                          district: "Sistema Solar", city: "Via lactea", state_code: "AA", zip_code: "99999-999",
                          description: "blablabla", buffet_owner: owner )
      buffet = Buffet.new(brand_name: "Buffet Galatico", corporate_name: "Buffetys LTDA", registration: "56673136000117",
                          phone_number: "99123456789", email: "atendimento@buffyts.com", address: "Rua Estrelas, 123",
                          district: "Sistema Solar", city: "Via lactea", state_code: "AA", zip_code: "99999-999",
                          description: "blablabla", buffet_owner: owner_1 )
      
      expect(buffet.valid?).to be_falsey
      
    end

    it "false when registration not unique" do
      owner = BuffetOwner.create!(email: "A@AA", password: "password")
      owner_1 = BuffetOwner.create!(email: "A@A", password: "password")
      Buffet.create!(brand_name: "Buffet Galaticoo", corporate_name: "Buffetys LTDAA", registration: "56673136000117",
                          phone_number: "99123456789", email: "atendimento@buffyts.com", address: "Rua Estrelas, 123",
                          district: "Sistema Solar", city: "Via lactea", state_code: "AA", zip_code: "99999-999",
                          description: "blablabla", buffet_owner: owner )
      buffet = Buffet.new(brand_name: "Buffet Galatico", corporate_name: "Buffetys LTDA", registration: "56673136000117",
                          phone_number: "99123456789", email: "atendimento@buffyts.com", address: "Rua Estrelas, 123",
                          district: "Sistema Solar", city: "Via lactea", state_code: "AA", zip_code: "99999-999",
                          description: "blablabla", buffet_owner: owner_1 )
      
      expect(buffet.valid?).to be_falsey
      
    end
  end
end
