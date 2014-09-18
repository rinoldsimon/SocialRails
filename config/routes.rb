Rails.application.routes.draw do
  get 'users/index'

  get 'users/show'

  resources :friendships

  get 'activities/index'

  resources :comments

  resources :posts

  devise_for :users

  get 'home/index'
  root :to => 'home#index' 

  get '/users/:id', :to => 'users#show', :as => :user

end
