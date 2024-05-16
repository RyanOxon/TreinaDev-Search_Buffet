class CreateRates < ActiveRecord::Migration[7.1]
  def change
    create_table :rates do |t|
      t.integer :score
      t.text :comment
      t.references :buffet, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.date :rated_at

      t.timestamps
    end
  end
end
