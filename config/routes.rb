Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #get 'tasks/index'

  post 'tasks/new'

  resources :tasks

  #root 'tasks#index'

  
  post 'criteria/new'
  post 'criteria/task_num' => 'criteria#task_num'

  resources :criteria

  post 'criteria/:id' => 'criteria#update'

  get 'criteria/:id/edit/crit_scale_new' => 'criteria#crit_scale_new', as: "criteria_crit_scale"
  post 'criteria/:id/edit/crit_scale_new' => 'criteria#crit_scale_new'

  post 'criteria/:id/edit/crit_scale_create' => 'criteria#crit_scale_create', as: "create_criteria_crit_scale"

  post 'criteria/:id/edit/crit_scale_destroy' => 'criteria#crit_scale_destroy', as: "criteria_crit_scale_destroy"
  get 'criteria/:id/edit/crit_scale_destroy' => 'criteria#crit_scale_destroy'


  post 'criteria/num_of_task' => 'criteria#num_of_task'



  post 'alternatives/new'
  post 'alternatives/task_num' => 'alternatives#task_num'
  resources :alternatives
  post 'alternatives/:id' => 'alternatives#update'


  get 'crit_values' => 'crit_values#index', as: "crit_values"
  post 'crit_values/create' => 'crit_values#create', as: "create_crit_value"
  #post 'crit_values' => 

  #post 'crit_values/new' => 'crit_values#new', as: "new_crit_value"
  #resources :crit_values


end
