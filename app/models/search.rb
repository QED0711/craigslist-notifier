class Search < ApplicationRecord

    belongs_to :user
    has_many :listings

end
