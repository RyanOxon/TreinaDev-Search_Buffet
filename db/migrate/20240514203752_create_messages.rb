class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.text :content
      t.references :order, null: false, foreign_key: true
      t.references :user, polymorphic: true, null: false
      t.datetime :posted_at

      t.timestamps
    end
  end
end
