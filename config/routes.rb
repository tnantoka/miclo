Rails.application.routes.draw do
  root to: 'welcome#index'

  controller :welcome do
    get :home
  end

  match '/auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match '/auth/failure', to: 'sessions#failure', via: [:get, :post]
  delete '/sign_out', to: 'sessions#destroy'

  resources :hashtags, only: [:index]
  resources :queries, only: [:index]
  get '/search', to: 'queries#show'

  resource :user, only: [:edit, :update, :destroy]
  resources :topics, only: [:destroy]
  resources :posts, only: [:new, :create, :update, :destroy] do
    collection do
      post :preview
    end
  end

  resources :users, only: [:show], path: :u, as: :u do
    resources :topics, only: [:show, :index], path: :t, as: :t do
      resources :posts, only: [:show], path: :p, as: :p
    end
  end
end
