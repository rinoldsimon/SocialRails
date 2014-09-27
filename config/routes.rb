Rails.application.routes.draw do
  get 'users/index'

  get 'users/show'

  resources :friendships

  get 'activities/index'
  get 'activities/user'

  resources :comments

  resources :posts

  devise_for :users

  get 'home/index'
  root :to => 'home#index' 

  get '/users/:id', :to => 'users#show', :as => :user

  get 'like' => 'users#like'
  get 'unlike' => 'users#unlike'

end
