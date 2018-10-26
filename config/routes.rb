Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: 'static#home'
  get '/request_access' => 'admin#request_access', as: 'request'
  post '/access' => 'admin#access'
  get '/request_received' => 'admin#request_received'
  get '/access' => 'admin#access_permission'
  post '/send_token' => 'admin#send_token'

  resources :users, only: [:create, :edit, :update] do
    resources :searches
  end
  get '/signup' => 'users#new'
  get '/login' => 'users#login'
  post '/signin' => 'users#signin'
  delete '/logout' => 'users#logout'


  get '/users/:user_id/currentsearches' => 'searches#searches_data', as: :current_searches
  post '/searches' => 'searches#create', as: 'new_searches'
  post '/toggle_active' => "searches#toggle_active"
  get '/searches/info/:id' => 'searches#search_info'


  get "*path" => redirect("/")

end
