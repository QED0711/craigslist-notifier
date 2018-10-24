class RequestMailer < ApplicationMailer

    default from: ENV["default_mailer"]

    def send_request(email)
        @email = email
        mail(to: ENV["admin_email"], subject: "Request for Access")
    end

end
