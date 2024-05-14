require 'rails_helper'

RSpec.describe ServiceProposal, type: :model do
  it "false when value empty" do
    proposal = ServiceProposal.new(value: '')
    proposal.valid?

    expect(proposal.errors.include?(:value)).to be true
  end

  it "false when expiration_date empty" do
    proposal = ServiceProposal.new(expiration_date: '')
    proposal.valid?

    expect(proposal.errors.include?(:expiration_date)).to be true
  end

  it "false when expiration_date is expired" do
    proposal = ServiceProposal.new(expiration_date: Date.yesterday)
    proposal.valid?

    expect(proposal.errors.include?(:expiration_date)).to be true
  end
end
