class Token < ApplicationRecord

    # belongs_to :user
    
    validates :code, :user_email, uniqueness: true, presence: true

    def self.generate_code_for(email)
        
        if Token.find_by(user_email: email)
            return false
        end

        new_token = Token.new
        new_token.user_email = email
        new_token.code = self.generate

        while !new_token.save
            new_token.code = self.generate
        end
        
        new_token
    end

    private

    def self.generate
        str = "CL"
        5.times {str += ENV["token_1"][rand(6)]}
        6.times {str += ENV["token_2"][rand(5)]}
        str
    end

end
