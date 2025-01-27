Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :generated_games, only: [:new, :create, :index, :show] do
    collection do
      get :drawned
    end
  end

  resources :draw_games, only: [:index] do
    # Define uma rota personalizada para o método 'seed_lotofacil_games'
    collection do
      post :seed_lotofacil_games
    end
  end

  root to: 'home#index'
end
