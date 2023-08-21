Rails.application.routes.draw do
  resources :reports do
    resources :comments, only: [:create, :destroy], module: :reports
  end
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users
  root to: 'books#index'
  resources :books do
resources :comments, only: [:create, :destroy], module: :books
  end
  resources :users, only: %i(index show)
  delete '/reports/:report_id/comments' => 'comments#destroy'
  delete '/books/:book_id/comments' => 'comments#destroy'
end
