class Listing < ApplicationRecord

    belongs_to :user
    belongs_to :search

    validates :url, uniqueness: true

end
