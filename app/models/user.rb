class User < ApplicationRecord

    has_many :searches
    has_many :listings

    has_secure_password

    enum authorization: [:admin, :user]

    validate :email, presence: true

end
