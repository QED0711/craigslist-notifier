class ApplicationController < ActionController::Base
    
    before_action :login_redirect
    helper_method :current_user

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
        if !logged_in?
            # raise user_searches_path(current_user).inspect
            redirect_to :root
        end
    end

end
