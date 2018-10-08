class UsersController < ApplicationController

    # before_action(new_user, only: [:login, :new])

    def login
        binding.pry
        @user = new_user
        @alert = alert 
    end

    def new
        binding.pry
        @user = new_user
    end

    def signin
        @user = User.find_by(email: params[:user][:email])
        if !!@user && @user.authenticate(params[:user][:password])
            session[:user_id] = @user.id
            redirect_to user
        else
            @user ||= User.new
            redirect_to :login, alert: "some errors"
            # binding.pry
        end
    end

    def create
        if params[:user][:confirm_password] && params[:user][:password] == params[:user][:confirm_password]
            user = User.new(user_params)
            if user.save
                session[:user_id] = user.id
                redirect_to user
            else
                @user = user
                render :signup
            end
        else
            user = User.new
            redirect_to signup_path, errors: "Some errors"
        end
    end

    def edit

    end

    def update

    end

    private

    def user_params
        params.require(:user).permit(:email, :password)
    end

    def new_user
        User.new
    end


end
