require 'rails_helper'

RSpec.describe PaymentMethod, type: :model do
  describe "#valid?" do
    it "false when method is empty" do
      method = PaymentMethod.new()
      expect(method.valid?).to be_falsey
    end
  end
end
