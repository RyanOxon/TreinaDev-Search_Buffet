class CreateBuffets < ActiveRecord::Migration[7.1]
  def change
    create_table :buffets do |t|
      t.string :brand_name
      t.string :corporate_name
      t.string :registration
      t.string :phone_number
      t.string :email
      t.string :full_address
      t.string :description
      t.references :buffet_owner, null: false, foreign_key: true

      t.timestamps
    end
  end
end
