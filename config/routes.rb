Rails.application.routes.draw do

  get 'home/index'
  root :to => 'home#index' 

  devise_for :users
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

end
