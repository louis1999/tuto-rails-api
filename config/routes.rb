Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  get 'ping' => 'application#ping'


  namespace :api do
    namespace :v1 do


      get 'books' => 'books#index_all'

      post 'login' => 'authentication#login'

      resources :users, only: [:create]

      resources :authors, only: [:index, :show, :create, :destroy] do
        resources :books, only: [:index, :create, :destroy]
      end
    end
  end






end
