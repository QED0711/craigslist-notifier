class CreateTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :tokens do |t|
      t.string :code
      t.string :user_email
      t.timestamps
    end
  end
end
