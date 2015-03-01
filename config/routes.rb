Rails.application.routes.draw do

  get 'messages/index'
  get 'messages/sent'

  get 'home/index'
  root :to => 'home#index' 

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  get 'users/index'
  get 'users/show'
  get '/users/:id', :to => 'users#show', :as => :user
  get 'like' => 'users#like'
  get 'unlike' => 'users#unlike'

  get 'activities/index'
  get 'activities/user'

  resources :comments
  resources :posts
  resources :friendships
  resources :messages

  resources :gchats, only: [:new, :create]
  get 'gchats/new'
  
end
