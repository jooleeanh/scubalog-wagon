Rails.application.routes.draw do

  mount Attachinary::Engine => "/attachinary"

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'pages#home'

  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, only: [:show, :destroy]
  resources :equipment_sets, only: [:new, :create, :edit, :update, :destroy]

  resources :divesites do
    get :search, :on => :collection
    resources :events, shallow: true do
      resources :participations, only: [:create, :new, :update, :destroy]
    end
  end

  resources :dives do
    resources :buddies
    resources :sightings, only: [:create, :update, :destroy]
    resources :data_points, only: [:create]
  end
end
