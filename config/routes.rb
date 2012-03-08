Hakata::Application.routes.draw do

  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  get 'users/:id/lists' => 'users#lists'
  post 'facts/set_key_bindings' => 'facts#set_key_bindings'

  resources :facts
  resources :lists
  resources :mnemonics
  resources :sessions
  resources :users
  resources :votes
  
  match 'sessions/cardview' => 'sessions#cardview'
  match 'lists/:list_id/facts/:fact_id/remove' => 'lists#removeFact'
  match 'lists/:list_id/facts/:id' => 'facts#show'
  
  root :to => 'front#index'
  
  resources :lists do
    collection { post :sort }
  end
end
