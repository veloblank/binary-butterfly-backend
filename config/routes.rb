Rails.application.routes.draw do
  namespace :api do 
    namespace :v1 do 
      get '/current', to: "contest_boards#current"
      resources :users, only: [:create, :show, :index] do
        resources :contest_boards, only: [:index, :show]
      end
      resources :contest_boards, only: [:show, :index, :create, :update, :destroy] do
        resources :contest_props, only: [:show, :index]
      end
      resources :contest_props
      resources :user_picks, only: [:create, :index, :show, :destroy, :update]
      resources :user_contest_boards, only:[:index, :destroy, :create]
    end
  end
end
