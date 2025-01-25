Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :generated_games, only: [:new, :create, :index, :show]
  resources :draw_games
  root to: 'home#index'
end
