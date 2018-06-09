Rails.application.routes.draw do
  devise_for :users
  resources :movies do
    resources :reviews, only: [:create, :destroy]
  end
  root "movies#index"
end
