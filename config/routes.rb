Rails.application.routes.draw do
  devise_for :users
  resources :books
  root to: 'books#index'
  
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  get '/users/:id' => 'users#show'
  get '/users' => 'users#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
