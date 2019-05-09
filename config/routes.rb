Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  resources :users
  get '/get_user_statistics', to: 'users#get_user_statistics', as: 'get_user_statistics'
  resources :periods
  resources :items
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/create_period/:nduration', to: 'periods#create_period', as: 'create_period'
  get '/get_periods', to: 'periods#get_periods', as: 'get_periods'
  get '/check_for_active_periods', to: 'periods#check_for_active_periods', as: 'check_for_active_periods'
  get '/deactivate_active_period', to: 'periods#deactivate_active_period', as: 'deactivate_active_period'
  get '/check_active_period', to: 'periods#check_active_period', as: 'check_active_period'
  get '/toggle_updated', to: 'periods#toggle_updated', as: 'toggle_updated'
  get '/get_report/:id', to: 'periods#get_report', as: 'get_report'

end
