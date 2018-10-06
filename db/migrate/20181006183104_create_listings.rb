class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.string :title
      t.string :price
      t.string :image
      t.string :url
      
      t.timestamps
    end
  end
end
