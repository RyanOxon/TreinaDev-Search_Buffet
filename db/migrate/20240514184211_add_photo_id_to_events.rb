class AddPhotoIdToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :photo_id, :integer
  end
end
