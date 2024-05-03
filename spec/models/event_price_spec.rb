require 'rails_helper'

RSpec.describe EventPrice, type: :model do
  context "#valid?" do
    it "false when empty" do
      price = EventPrice.new()

      expect(price.valid?).to be_falsey 
    end
  end
end
