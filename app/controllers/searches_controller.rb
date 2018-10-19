class SearchesController < ApplicationController
  
  # skip_before_action :login_redirect, only: [:index, :new, :searches_data, :create, :toggle_active, :destroy, :search_info, :update]

  def index # user_searches_path(current_user)
    redirect_to :root if !logged_in?
    @user = current_user
    # ListingMailer.test_email(@user).deliver
    @searches = current_user.searches
  end

  # def show
  # end

  def new
    @user = current_user
  end

  def create
    current_user.searches.create(search_params)
    # @search = Search.new(search_params)
    # @search.user_id = current_user.id
    # @search.save
    render json: @search, status: 201
    # binding.pry
  end

  # def edit
  # end

  def update
    @search = Search.find(params[:id])
    if @search.url != params[:search][:url]
      @search.listings.each do |listing|
        listing.delete
      end
    end
    # binding.pry
    @search.update(search_params)
    # @search.save
    render nothing: true, status: 204
  end

  def destroy
    # binding.pry
    @search = Search.find(params[:id])
    @search.listings.each do |listing|
      listing.delete
    end
    @search.delete
    redirect_to user_searches_path(params[:user_id])
  end

  def searches_data
    searches = User.find(params[:user_id]).searches.as_json(only: [:id, :url, :description, :user_id, :active])
    render json: searches
  end

  def toggle_active
    # binding.pry
    @search = Search.find(params[:search][:id])
    @search.active = !@search.active
    @search.save
    render json: @search, status: 204
  end

  def search_info
    search = Search.find(params[:id]).to_json(only: [:id, :url, :description, :user_id])
    render json: search
    # binding.pry
  end

  private

  def search_params
    params.require(:search).permit(:url, :description, :active)
  end
end
