Rails.application.routes.draw do
  resources :posts

  devise_for :users

  get 'home/index'
  root :to => 'home#index' 

end
