class UsersController < ApplicationController

    skip_before_action :login_redirect, only: [:login, :new, :signin, :create, :edit]

    def login
        @user = User.new
        @alert = alert 
        render layout: "pre_login"
    end

    def new
        @user = User.new
        render layout: "pre_login"
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
        if Token.authenticate(params[:access_token], params[:user][:email])
            if params[:user][:confirm_password] && params[:user][:password] == params[:user][:confirm_password]
                user = User.new(user_params)
                if user.save
                    session[:user_id] = user.id
                    redirect_to user_searches_path(current_user)
                else
                    @user = user
                    render :new, layout: "pre_login"
                end
            else
                @user = User.new
                @errors = "Passwords must be the same"
                render :new, layout: "pre_login"
            end
        else
            @user = User.new
            @errors = "Invalid Access Token"
            render :new, layout: "pre_login"
        end
    end

    def logout
        # raise "hit this".inspect
        session.clear
        # raise session[:user_id].inspect
        redirect_to :root
    end

    def edit
        @user = current_user
    end

    def update
        @user = current_user
        if @user.authenticate(params[:user][:password])
            @user.email = params[:user][:email]
            if params[:user][:new_password] != ""
                @user.password = params[:user][:new_password]
                @user.save
                redirect_to :root
            else
                @user.save
                redirect_to :root
            end
        else
            @errors = "Incorrect password"
            render :edit
        end
    end



    private

    def user_params
        params.require(:user).permit(:email, :password)
    end

    


end
