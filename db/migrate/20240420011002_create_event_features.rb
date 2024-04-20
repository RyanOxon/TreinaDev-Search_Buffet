class CreateEventFeatures < ActiveRecord::Migration[7.1]
  def change
    create_table :event_features do |t|
      t.references :event
      t.references :feature

      t.timestamps
    end
  end
end
