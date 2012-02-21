Hakata::Application.routes.draw do
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  resources :users
  resources :sessions
  resources :fields
  resources :lists
  resources :mnemonics
  resources :facts
  match 'sessions/cardview' => 'sessions#cardview'
  match 'lists/:list_id/facts/:id' => 'facts#show'
  root :to => 'home#index'
  resources :lists do 
    collection { post :sort}
  end
end
