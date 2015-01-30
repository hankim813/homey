Rails.application.routes.draw do


  # Token Auth
  post 'api/auth' => 'auth#authenticate', defaults: { format: 'json' }

  # Login/Register
  post 'api/login' => 'users#find', defaults: { format: 'json' }
  post 'api/register' => 'users#create', defaults: { format: 'json' }
  post 'api/fb' => 'users#fb', defaults: { format: 'json' }
  post 'api/serviceProviders/register' => 'providers#create', defaults: { format: 'json' }
  post 'api/serviceProviders/login' => 'providers#find', defaults: { format: 'json' }
  post 'api/admin/register' => 'admin#create', defaults: { format: 'json' }
  post 'api/admin/login' => 'admin#find', defaults: { format: 'json' }

  # Users
  get 'api/users' => 'users#index', defaults: { format: 'json' }
  get 'api/users/:id' => 'users#show', defaults: { format: 'json'}
  put 'api/users/edit' => 'users#edit', defaults: { format: 'json'}
  delete 'api/users/:id/delete' => 'users#delete', defaults: { format: 'json'}

  # Service Providers
  get 'api/serviceProviders' => 'providers#index', defaults: { format: 'json' }
  get 'api/serviceProviders/:id' => 'providers#show', defaults: { format: 'json'}
  put 'api/serviceProviders/:id/edit' => 'providers#edit', defaults: { format: 'json'}
  delete 'api/serviceProviders/:id/delete' => 'providers#delete', defaults: { format: 'json'}

  # Admin
  get 'api/admin' => 'admin#index', defaults: { format: 'json' }
  get 'api/admin/:id' => 'admin#show', defaults: { format: 'json'}
  put 'api/admin/:id/edit' => 'admin#edit', defaults: { format: 'json'}
  delete 'api/admin/:id/delete' => 'admin#delete', defaults: { format: 'json'}


  # Appointments
  get 'api/users/:id/appointments' => 'appointments#show', defaults: { format: 'json' }
  put 'api/appointments/:id/pay' => 'appointments#pay', defaults: { format: 'json' }
  put 'api/appointments/:id/complete' => 'appointments#complete', defaults: { format: 'json' }
  put 'api/appointments/:id/cancel' => 'appointments#cancel', defaults: { format: 'json' }
  post 'api/users/:id/appointments' => 'appointments#create', defaults: { format: 'json' }

  # Bookings

  post 'api/appointments/bookings/home-cleanings' => 'bookings#home_cleanings', defaults: { format: 'json' }
  post 'api/appointments/bookings/office-cleanings' => 'bookings#office_cleanings', defaults: { format: 'json' }
  post 'api/appointments/bookings/car-washes' => 'bookings#car_washes', defaults: { format: 'json' }
  post 'api/appointments/bookings/drivers' => 'bookings#drivers', defaults: { format: 'json' }
  post 'api/appointments/bookings/securities' => 'bookings#securities', defaults: { format: 'json' }
  post 'api/appointments/bookings/chefs' => 'bookings#chefs', defaults: { format: 'json' }
  post 'api/appointments/bookings/gardenings' => 'bookings#gardenings', defaults: { format: 'json' }
  post 'api/appointments/bookings/contractors' => 'bookings#contractors', defaults: { format: 'json' }

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
