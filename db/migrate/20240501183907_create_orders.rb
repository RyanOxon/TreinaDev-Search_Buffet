class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :event, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.date :date
      t.integer :people_count
      t.string :code
      t.string :details
      t.string :address
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
