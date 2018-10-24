class StaticController < ApplicationController
    skip_before_action :login_redirect, only: [:home, :request_access, :access]
    def home
        if logged_in?
            redirect_to user_searches_path(current_user) if logged_in? 
        else
            render layout: "pre_login"
        end
    end

    def request_access
        render layout: "pre_login"
    end

    def access
        binding.pry
    end

end
