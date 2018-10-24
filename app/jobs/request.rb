class Request

    def self.send_request(email)
        RequestMailer.send_request(email).deliver
    end

end