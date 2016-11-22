Rails.application.routes.draw do

  root to: 'pages#home'
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, only: [:show, :destroy], shallow: true do
    resources :equipment_sets, only: [:new, :create, :edit, :update, :destroy]
    resources :participations, only: [:create, :update, :destroy]
  end
  resources :dives do
    resources :buddies
    resources :sightings, only: [:create, :update, :destroy]
    resources :data_points, only: [:create]
  end
  resources :divesites do
    resources :events
  end
end
