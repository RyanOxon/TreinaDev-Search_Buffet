class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name
      t.string :description
      t.integer :min_capacity
      t.integer :max_capacity
      t.integer :default_duration
      t.text :menu
      t.boolean :exclusive_address
      t.references :buffet, null: false, foreign_key: true
      t.references :event_category, null: false, foreign_key: true
      t.timestamps
    end
  end
end
