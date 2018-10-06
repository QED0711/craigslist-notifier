class ApplicationController < ActionController::Base

    private

    def logged_in?
        !!session[:user_id]
    end

end
