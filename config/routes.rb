Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'

  resources :divesites
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:show, :destroy] do
    resources :dives
  end

  resources :events do
  end
end
