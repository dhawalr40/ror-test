Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      post "auth/login", to: "auth#login"

      resources :brands, only: [:index] do
        get :products, on: :member
      end

      resources :orders, only: [:create, :show] do
        member do
          patch :cancel
          patch :confirm
        end
      end

      resources :products, only: [:index, :create, :update]
    end
  end
end
