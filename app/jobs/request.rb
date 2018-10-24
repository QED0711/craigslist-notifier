class Request

    def self.send_request(email)
        RequestMailer.send_request(email).deliver
    end

    def self.generate_token
        str = "CL"
        3.times {str += ENV["token_1"][rand(6)]}
        2.times {str += ENV["token_2"][rand(5)]}
        str
    end

    def self.authenticate_token(token)
        !!token.match(Regexp.new(ENV['token_auth']))
    end

end