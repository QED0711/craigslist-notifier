class AddLocationToListing < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :location, :string
  end
end
