class CreateServiceProposals < ActiveRecord::Migration[7.1]
  def change
    create_table :service_proposals do |t|
      t.references :order, null: false, foreign_key: true
      t.references :payment_method, null: false, foreign_key: true
      t.integer :status, default: 0
      t.integer :value
      t.integer :extra_fee, default: 0
      t.integer :discount, default: 0
      t.string :description
      t.date :expiration_date

      t.timestamps
    end
  end
end
