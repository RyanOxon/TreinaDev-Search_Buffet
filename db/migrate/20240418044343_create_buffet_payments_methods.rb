class CreateBuffetPaymentsMethods < ActiveRecord::Migration[7.1]
  def change
    create_table :buffet_payments_methods do |t|

      t.references :buffet, null: false, foreign_key: true
      t.references :payment_methods, null: false, foreign_key: true

      t.timestamps
    end
  end
end
