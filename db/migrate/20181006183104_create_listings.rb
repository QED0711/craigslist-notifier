class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.string :title
      t.string :price
      t.string :image
      t.string :url
      t.string :map
      t.string :condition
      t.string :location
      
      t.integer :search_id
      t.integer :user_id
      
      t.timestamps
    end
  end
end
