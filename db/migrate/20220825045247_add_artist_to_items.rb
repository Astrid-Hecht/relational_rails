class AddArtistToItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :artist, foreign_key: true
  end
end
