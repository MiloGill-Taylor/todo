Rails.application.routes.draw do
  root 'task_lists#index'

  resources :tasks
end
