class User < ApplicationRecord

    has_many :searches
    has_many :listings

    has_secure_password

    enum authorization: [:admin, :user]

    validates :email, presence: true, uniqueness: true


end
