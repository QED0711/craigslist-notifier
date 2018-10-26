class AdminController < ApplicationController

    skip_before_action :login_redirect, only: [:request_access, :access, :request_received]
    before_action :admin_access, only: [:send_access_code]

    def start_searches

    end

    def manage_requests

    end

    def request_access
        render layout: "pre_login"
    end

    def access
        # binding.pry
        Request.delay.send_request(params[:email])
        redirect_to :request_received
    end

    def request_received
        render layout: "pre_login"
    end

    def access_permission
    end

    def send_token
        # binding.pry
        email = params[:email]
        
        if params[:grant_access].to_i == 1
            token = Token.generate_code_for(email)
            if token
                Request.delay.send_token(email, token.code)
            else
                token = Token.find_by(user_email: email)
                Request.delay.send_token(email, token.code)
            end
        else
            Request.delay.send_access_denied(email)
        end
        redirect_to :root
    end

end