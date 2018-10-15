class AddBaseToListing < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :base, :boolean, :default => false
  end
end
