class SearchesController < ApplicationController
  def index
    @user = current_user
  end

  def show
  end

  def new
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
