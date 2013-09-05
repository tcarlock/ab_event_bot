EventBot::Application.routes.draw do
  resources :event_sources
  resources :events do
    member do
      post :approve
      post :reject
      get :preview_json
    end
  end

  get :process_events, to: 'main#process_events'
  root to: 'main#index'
end
