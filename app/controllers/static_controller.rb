class StaticController < ApplicationController

    def home
        redirect_to user_searches_path(current_user) if logged_in? 
    end

end
