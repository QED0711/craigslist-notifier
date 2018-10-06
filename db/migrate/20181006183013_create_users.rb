class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :location
      t.integer :authorization, default: 1 #defaults to regular user

      t.timestamps
    end
  end
end
