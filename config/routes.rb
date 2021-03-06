Rails.application.routes.draw do
  resources :leaves
  resources :leave_types
  resources :teams do
    member do
      get :calendar
    end
  end
  resources :legal_days
  resources :users do
    collection do
      get :login
      get :logout
      post :signin
    end
    member do
      get :calendar
    end
    resources :leave_requests
  end
  match 'login' => 'users#login', via: :get, as: :login
  match 'logout' => 'users#logout', via: :get, as: :logout
  match 'signin' => 'users#signin', via: :post, as: :signin

  resources :sites
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'users#show'
  
end
