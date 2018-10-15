class ListingMailer < ApplicationMailer

    default from: "qdizon@gmail.com"

    def sample_email
        @user = User.find_by(email: "qdizon@gmail.com")
        mail(to: @user.email, subject: "Sample Email")
    end

end
