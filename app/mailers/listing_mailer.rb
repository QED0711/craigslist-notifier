class ListingMailer < ApplicationMailer

    default from: ENV["default_mailer"]

    def send_new_listings(search)
        @search = search
        @listings = search.listings.where(base: false)
        @user = search.user
        mail(to: @user.email, subject: "New Craigslist Listings!")
    end

end
