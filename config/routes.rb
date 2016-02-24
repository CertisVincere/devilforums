Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  get 'sessions/new'

  resources :users
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :groups do
    collection do
      get 'search'
    end
    resources :topics do
      resources :posts
    end
  end

  get 'contact' => 'pages#contact'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  root 'sessions#new'
end
