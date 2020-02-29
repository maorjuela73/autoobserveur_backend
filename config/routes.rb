Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  resources :users
  get '/get_user_statistics', to: 'users#get_user_statistics', as: 'get_user_statistics'
  resources :periods
  resources :items
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/create_period/:nduration', to: 'periods#create_period', as: 'create_period'
  get '/period_report/:periodid', to: 'periods#period_report', as: 'period_report'
  get '/period_report_filtered/:periodid', to: 'periods#period_report_filtered', as: 'period_report_filtered'

  get '/get_periods', to: 'periods#get_periods', as: 'get_periods'
  get '/get_inactive_periods', to: 'periods#get_inactive_periods', as: 'get_check_for_active_periodsinactive_periods'

  get '/check_for_active_periods', to: 'periods#check_for_active_periods', as: 'check_for_active_periods'
  get '/deactivate_active_period', to: 'periods#deactivate_active_period', as: 'deactivate_active_period'
  get '/check_active_period', to: 'periods#check_active_period', as: 'check_active_period'
  get '/get_completion_percentage', to: 'periods#get_completion_percentage', as: 'get_completion_percentage'
  get '/toggle_updated', to: 'periods#toggle_updated', as: 'toggle_updated'
  get '/get_report/:id', to: 'periods#get_report', as: 'get_report'

  get '/get_advices/:itemid', to: 'advices#get_advices', as: 'get_advices'

  get 'get_current_user' => 'users#get_current_user'

  post '/post_period_item', to: 'period_items#create_period_item', as: 'create_period_item'
  get '/get_perioditem_list', to: 'period_items#get_perioditem_list', as: 'get_perioditem_list'

  post '/post_mark', to: 'marks#create_mark', as: 'create_mark'

end
