Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: 'static#home'
  
  resources :users, only: [:create, :edit, :update] do
    resources :searches
  end
  get '/signup' => 'users#new'
  get '/login' => 'users#login'
  post '/signin' => 'users#signin'
  
  get '/users/:user_id/current_searches' => 'searches#searches_data', as: :current_searches

end
