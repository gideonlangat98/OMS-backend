Rails.application.routes.draw do
  resources :projects

  resources :events do
    get 'download_document', on: :member, to: 'events#download_document', as: 'download_document'
  end

  mount ActionCable.server => '/cable'

  scope '/messages' do
    post '/send_to_admin/:admin_id', to: 'messages#send_to_admin', as: 'send_to_admin_message'
    post '/send_to_staff/:staff_id', to: 'messages#send_to_staff', as: 'send_to_staff_message'
    get '/received_messages', to: 'messages#received_messages', as: 'received_messages'
    get '/sent_messages', to: 'messages#sent_messages', as: 'sent_messages'
    put '/:id', to: 'messages#update', as: 'update_message'
    delete '/:id', to: 'messages#destroy', as: 'destroy_message'
  end

  resources :tasks do
    collection do
      get 'completed_tasks', to: 'tasks#completed_tasks'
      get 'admin_received_tasks', to: 'tasks#admin_received_tasks'
      get 'received_tasks', to: 'tasks#received_tasks'
      get 'admin_sent_tasks_to_staff', to: 'tasks#admin_sent_tasks_to_staff'
      get 'admin_all_tasks', to: 'tasks#admin_all_tasks'
      get 'admin_received_completed_files', to: 'tasks#admin_received_completed_files'

    end
    
    put 'upload_completed_files', to: 'tasks#upload_completed_files', as: 'upload_completed_files'
    get 'download_avatar', on: :member, to: 'tasks#download_avatar', as: 'download_avatar'
    get 'download_completed_file/:file_index', action: :download_completed_file, as: 'download_completed_file'
  end

  resources :clients
  resources :managers
  resources :forms
  resources :leave_types
  resources :company_articles
  resources :timesheets, except: [:new, :edit], defaults: { format: 'json' }
  resources :end_timesheets
  resources :leave_calculations
  resources :admins
  resources :profiles
  resources :requests

  resources :progresses do
    
    collection do
      get 'received_progresses', to: 'progresses#received_progresses', as: 'received_progresses' 
    end

    member do
      put 'update_seen', to: 'progresses#update_seen', as: 'update_seen_progress'
    end
  end
  

  resources :staffs do
    member do
      get 'forms', to: 'staffs#forms'
      get 'tasks', to: 'staffs#tasks'
      get 'leave_calculations', to: 'staffs#leave_calculations'
      get 'timesheets', to: 'staffs#timesheets'
      get 'end_timesheets', to: 'staffs#end_timesheets'
      get 'profile', to: 'staffs#profile'
    end
  end

  
  resources :check_in_outs, only: [:index, :show, :destroy]
  
  post 'check_in_outs/check_in', to: 'check_in_outs#check_in'
  post 'check_in_outs/check_out', to: 'check_in_outs#check_out'

  post '/staffs', to: 'staffs#create'
  post '/admins', to: 'admins#create'
  post '/login', to: 'sessions#create'
  get '/me', to: 'staffs#show'
  get '/mi', to: 'admins#show'
  delete '/logout', to: 'sessions#destroy'

  # Route for generating a password for an admin
  get "/gen_pass/:id", to: "admins#gen_pass"
  get "/gen_pass/:id", to: "events#gen_pass"
end
