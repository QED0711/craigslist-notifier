class ApplicationController < ActionController::Base

    private

    def logged_in?
        !!session[:user_id]
    end

    def log_in
        binding.pry
        session[:user_id] = @user.id
    end

    def current_user
        User.find(session[:user_id])
    end

end
