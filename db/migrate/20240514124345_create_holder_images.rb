class CreateHolderImages < ActiveRecord::Migration[7.1]
  def change
    create_table :holder_images do |t|
      t.references :holder, polymorphic: true, null: false
      t.references :user, polymorphic: true, null: false
      t.datetime :uploaded_at

      t.timestamps
    end
  end
end
