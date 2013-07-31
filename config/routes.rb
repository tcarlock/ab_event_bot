EventBot::Application.routes.draw do
  resources :event_sources
  resources :events do
    member do
      post :approve
      post :reject
      get :preview_json
    end
  end

  root to: 'main#index'
end
