# Preview all emails at http://localhost:3000/rails/mailers/listin_mailer
class ListingMailerPreview < ActionMailer::Preview
    def test_email
        ListingMailer.test_email(User.first)
    end
end
