class User < ApplicationRecord

    has_many :searches
    has_many :listings

    has_secure_password

    enum authorization: [:admin, :user]

    validates :email, presence: true, uniqueness: true


    def new_listings
        self.searches.collect do |search|
            lis = search.listings.where(user_id: self.id, base: false) 
            if !lis.empty?
                lis
            end
        end.flatten
    end

end
