class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name
      t.string :description
      t.integer :min_capacity
      t.integer :max_capacity
      t.integer :default_duration
      t.text :menu
      t.references :buffet

      t.timestamps
    end
  end
end
