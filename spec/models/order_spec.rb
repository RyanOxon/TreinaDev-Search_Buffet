require 'rails_helper'

RSpec.describe Order, type: :model do
  context '#valid?' do
    it 'false when date is empty' do
      order = Order.new(date: '')
      order.valid?

      expect(order.errors.include?(:date)).to be true
    end

    it 'false when people_count is empty' do
      order = Order.new(people_count: '')
      order.valid?

      expect(order.errors.include?(:people_count)).to be true
    end

    it 'false when date is expired' do
      order = Order.new(date: 2.day.ago)
      order.valid?

      expect(order.errors.include?(:date)).to be true
    end
  end
end
