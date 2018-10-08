class CreateSearches < ActiveRecord::Migration[5.2]
  def change
    create_table :searches do |t|
      t.string :url
      t.integer :user_id
      t.text :description
      t.timestamps
    end
  end
end
