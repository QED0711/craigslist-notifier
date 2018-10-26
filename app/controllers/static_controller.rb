class StaticController < ApplicationController
    skip_before_action :login_redirect, only: [:home]

    def home
        if logged_in?
            redirect_to user_searches_path(current_user) if logged_in? 
        else
            render layout: "pre_login"
        end
    end

end
