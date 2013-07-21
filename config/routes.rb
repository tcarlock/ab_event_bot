EventBot::Application.routes.draw do
  post :process_events, to: 'main#process_events'

  resources :event_sources
  resources :events do
    member do
      post :approve
      get :preview_json
    end
  end

  root to: 'main#index'
end
