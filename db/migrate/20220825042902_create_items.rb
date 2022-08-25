class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.timestamps
      
      t.string :name
      t.float :rating
      t.float :price
      t.integer :stock
      t.integer :num_sold
      t.boolean :free_shipping
    end
  end
end
