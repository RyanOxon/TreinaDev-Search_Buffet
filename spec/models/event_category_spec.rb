require 'rails_helper'

RSpec.describe EventCategory, type: :model do
  context "#valid?" do
    it "false when empty" do
      category = EventCategory.new()

      expect(category.valid?).to be_falsey 
    end
  end
end
