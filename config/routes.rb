Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #get 'tasks/index'

  post 'tasks/new'

  resources :tasks

  #root 'tasks#index'

  post 'criteria/new'

  resources :criteria

  
end
