class CreateEventFeatures < ActiveRecord::Migration[7.1]
  def change
    create_table :event_features do |t|
      t.references :event, null: false, foreign_key: true
      t.references :feature, null: false, foreign_key: true

      t.timestamps
    end
  end
end
