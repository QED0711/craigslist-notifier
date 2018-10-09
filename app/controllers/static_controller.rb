class StaticController < ApplicationController
    skip_before_action :login_redirect, only: [:home]
    def home
        render layout: false
        redirect_to user_searches_path(current_user) if logged_in? 
    end

end
