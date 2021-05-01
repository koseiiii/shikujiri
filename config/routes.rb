Rails.application.routes.draw do
  get 'hello/index' => 'hello#index'
  root to:"posts#index"
  devise_for :users
  resources :users, only: [:show, :edit, :create, :update]
  
  resources :posts do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]
  end
  
end
