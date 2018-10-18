class ListingMailer < ApplicationMailer

    default from: "notifier.cl@gmail.com"

    def sample_email
        @user = User.find_by(email: "qdizon@gmail.com")
        mail(to: @user.email, subject: "Sample Email")
    end

    def test_email(user)
        @user = user
        mail(to: @user.email, subject: "this is a test")
    end

    def new_listings(user)
        @user = user
    end

end
