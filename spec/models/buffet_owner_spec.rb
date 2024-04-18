require 'rails_helper'

RSpec.describe BuffetOwner, type: :model do
  describe "#valid?" do
    it "false when email is empty" do
      user = BuffetOwner.new(email: "", password: "abcdefg" )

      expect(user.valid?).to be_falsey 
    end
    
    it "false when password is empty" do
      user = BuffetOwner.new(email: "teste@teste.com", password: "" )

      expect(user.valid?).to be_falsey
    end
  end
end
