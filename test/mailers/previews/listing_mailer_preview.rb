# Preview all emails at http://localhost:3000/rails/mailers/listin_mailer
class ListingMailerPreview < ActionMailer::Preview
    def test_email
        ListingMailer.test_email(User.first)
    end

    def send_new_listings
        ListingMailer.send_new_listings(Search.first)
    end
    # http://localhost:3000/rails/mailers/listing_mailer/send_new_listings
end
