class CreateEventCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :event_categories do |t|
      t.integer :category
      t.references :event
      
      t.timestamps
    end
  end
end
