Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    
    
    root to: 'index#index'
    
    resources :projects do
        resources :tasks do
                get 'up'  => 'tasks#up'
                get 'down'  => 'tasks#down'
        end
    end
        
    resources :users
    
end
