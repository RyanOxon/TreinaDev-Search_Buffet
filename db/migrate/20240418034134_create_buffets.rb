class CreateBuffets < ActiveRecord::Migration[7.1]
  def change
    create_table :buffets do |t|
      t.string :brand_name
      t.string :corporate_name
      t.string :registration
      t.string :phone_number
      t.string :email
      t.string :address
      t.string :district
      t.string :city
      t.string :state_code
      t.string :zip_code
      t.string :description
      t.references :buffet_owner, null: false, foreign_key: true

      t.timestamps
    end
  end
end
