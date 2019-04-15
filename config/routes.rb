Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  resources :users
  resources :periods
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/create_period/:nduration', to: 'periods#create_period', as: 'create_period'
  get '/get_periods', to: 'periods#get_periods', as: 'get_periods'
  get '/check_for_active_periods', to: 'periods#check_for_active_periods', as: 'check_for_active_periods'
  get '/get_active_period', to: 'periods#get_active_period', as: 'get_active_period'
  get '/switch_updated/:id', to: 'periods#switch_updated', as: 'switch_updated'

end
