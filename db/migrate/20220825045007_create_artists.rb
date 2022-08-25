class CreateArtists < ActiveRecord::Migration[5.2]
  def change
    create_table :artists do |t|
      t.timestamps
      
      t.string :username
      t.string :location
      t.integer :followers
      t.boolean :accepts_returns
    end
  end
end
