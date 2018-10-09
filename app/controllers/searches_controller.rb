class SearchesController < ApplicationController
  
  skip_before_action :login_redirect, only: [:index, :new, :searches_data]

  def index # user_searches_path(current_user)
    redirect_to :root if !logged_in?
    @user = current_user
  end

  def show
  end

  def new
    @user = current_user
  end

  def create
  end

  def edit
  end

  def update
  end

  def delete
  end

  def searches_data
    searches = User.find(params[:user_id]).searches.as_json(only: [:url, :description, :user_id])
    render json: searches
  end
end
