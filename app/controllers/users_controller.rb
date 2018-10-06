class UsersController < ApplicationController

    # before_action(new_user, only: [:login, :new])

    def login
        # binding.pry
    end

    def new

    end

    def create

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
        @user = User.new
    end


end
