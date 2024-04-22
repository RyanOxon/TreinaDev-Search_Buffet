class CreateEventPrices < ActiveRecord::Migration[7.1]
  def change
    create_table :event_prices do |t|
      t.integer :price_type
      t.integer :base_value
      t.integer :extra_per_person
      t.integer :extra_per_hour
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
