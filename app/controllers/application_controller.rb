class ApplicationController < ActionController::Base
    
    before_action :login_redirect

    private

    def logged_in?
        !!session[:user_id]
    end

    def current_user
        if logged_in?
            User.find(session[:user_id])
        else
            nil
        end
    end

    def login_redirect
        # raise "We hit this method".inspect
        if logged_in?
            redirect_to user_searches_path(current_user)
        else
            redirect_to :root
        end
    end

end
