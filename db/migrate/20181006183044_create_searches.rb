class CreateSearches < ActiveRecord::Migration[5.2]
  def change
    create_table :searches do |t|
      t.string :url
      t.text :description
      t.integer :user_id
      t.boolean :active, default: true
      t.timestamps
    end
  end
end
