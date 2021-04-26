Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :forecast, only: :index
      resources :background, only: :index
      resources :users, only: :create
      resources :sessions, only: :create
      resources :road_trip, only: :create
      resources :salaries, only: :index
    end
  end
end
