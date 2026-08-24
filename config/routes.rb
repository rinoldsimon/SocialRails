Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  get "up" => "rails/health#show", as: :rails_health_check

  resources :users, only: [ :index, :show ], param: :username do
    resource :follow, only: :create
  end
  resources :follows, only: :destroy

  resources :posts, only: [ :create, :destroy ] do
    resources :comments, only: [ :create, :destroy ]
  end
  resources :likes, only: [ :create, :destroy ]

  resources :conversations, only: [ :index, :show, :create ] do
    resources :direct_messages, only: :create
  end

  get "yard", to: "yard#show", as: :yard
  resources :chat_messages, only: :create

  if Rails.env.development?
    require "letter_opener_web"
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  root "home#index"
end
