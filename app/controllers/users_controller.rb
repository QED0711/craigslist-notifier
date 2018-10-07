class UsersController < ApplicationController

    # before_action(new_user, only: [:login, :new])

    def login
        @user = new_user
    end

    def new
        @user = new_user
    end

    def signin
        raise "Got to signin"
    end

    def create

        @user = User.find_or_create_by()
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
