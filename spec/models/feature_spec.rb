require 'rails_helper'

RSpec.describe Feature, type: :model do
  context "#valid?" do
    it "false when empty" do
      feature = Feature.new()

      expect(feature.valid?).to be_falsey
    end

    it "must be unique" do
      Feature.create!(feature: "valet")
      feature = Feature.new(feature: "valet")

      expect(feature.valid?).to be_falsey
    end
  end
end
