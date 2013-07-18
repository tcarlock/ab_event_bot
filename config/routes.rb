EventBot::Application.routes.draw do
  
  resources :event_sources


  post :add_source, to: 'main#add_source'


  resources :events do
    member do
      post :approve
    end
  end

  root to: 'main#index'
end
