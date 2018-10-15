class UsersController < ApplicationController

    skip_before_action :login_redirect, only: [:login, :new, :signin, :create]

    def login
        @user = User.new
        @alert = alert 
        render layout: false
    end

    def new
        @user = User.new
        render layout: false
    end

    def signin
        @user = User.find_by(email: params[:user][:email])
        if !!@user && @user.authenticate(params[:user][:password])
            session[:user_id] = @user.id
            redirect_to user_searches_path(current_user)
        else
            @user ||= User.new
            redirect_to :login, alert: "Incorrect Email of Password"
        end
    end

    def create
        if params[:user][:confirm_password] && params[:user][:password] == params[:user][:confirm_password]
            user = User.new(user_params)
            if user.save
                session[:user_id] = user.id
                redirect_to user_searches_path(current_user)
            else
                @user = user
                render :new
            end
        else
            user = User.new
            redirect_to signup_path, errors: "Invalid Email or Password"
        end
    end

    def logout
        # raise "hit this".inspect
        session.clear
        # raise session[:user_id].inspect
        redirect_to :root
    end

    def edit

    end

    def update

    end

    private

    def user_params
        params.require(:user).permit(:email, :password)
    end

    


end
