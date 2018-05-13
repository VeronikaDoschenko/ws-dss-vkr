Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #get 'tasks/index'

  post 'tasks/new'

  resources :tasks

  #root 'tasks#index'

  
  post 'criteria/new'

  resources :criteria

  post 'criteria/:id' => 'criteria#update'

  get 'criteria/:id/edit/crit_scale_new' => 'criteria#crit_scale_new', as: "criteria_crit_scale"
  post 'criteria/:id/edit/crit_scale_new' => 'criteria#crit_scale_new'

  post 'criteria/:id/edit/crit_scale_create' => 'criteria#crit_scale_create'

  post 'criteria/:id/edit/crit_scale_destroy' => 'criteria#crit_scale_destroy', as: "criteria_crit_scale_destroy"
  get 'criteria/:id/edit/crit_scale_destroy' => 'criteria#crit_scale_destroy'


  post 'criteria/num_of_task' => 'criteria#num_of_task'


  post 'alternatives/new'
  resources :alternatives
  post 'alternatives/:id' => 'alternatives#update'
  post 'alternatives' => 'alternatives#task_num'



  resources :crit_values


end
