class RequestMailer < ApplicationMailer

    default from: ENV["default_mailer"]

    def send_request(email)
        @email = email
        mail(to: ENV["admin_email"], subject: "Request for Access")
    end

    def send_token(email, token)
        @email = email
        @token = token
        mail(to: @email, subject: "Your Craigslist Notifier Token")
    end

    def send_access_denied(email)
        @email = email
        mail(to: @email, subject: "Token Request")
    end

end
