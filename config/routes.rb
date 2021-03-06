Rails.application.routes.draw do


  # Token Auth
  post 'api/auth' => 'auth#authenticate', defaults: { format: 'json' }

  # Login/Register
  post 'api/users/login' => 'users#find', defaults: { format: 'json' }
  post 'api/users/register' => 'users#create', defaults: { format: 'json' }
  post 'api/users/fb' => 'users#fb', defaults: { format: 'json' }
  post 'api/serviceProviders/register' => 'providers#create', defaults: { format: 'json' }
  post 'api/serviceProviders/login' => 'providers#find', defaults: { format: 'json' }
  post 'api/admins/register' => 'admins#create', defaults: { format: 'json' }
  post 'api/admins/login' => 'admins#find', defaults: { format: 'json' }

  # Users
  get 'api/users' => 'users#index', defaults: { format: 'json' }
  get 'api/users/:id' => 'users#show', defaults: { format: 'json'}
  # ASK FOR ID's
  put 'api/users/:id/edit' => 'users#edit', defaults: { format: 'json'}
  delete 'api/users/:id/delete' => 'users#delete', defaults: { format: 'json'}

  # Service Providers
  get 'api/serviceProviders' => 'providers#index', defaults: { format: 'json' }
  get 'api/serviceProviders/:id' => 'providers#show', defaults: { format: 'json'}
  # ASK FOR ID's
  put 'api/serviceProviders/:id/edit' => 'providers#edit', defaults: { format: 'json'}
  delete 'api/serviceProviders/:id/delete' => 'providers#delete', defaults: { format: 'json'}

  # Admin
  get 'api/admins/:id' => 'admins#show', defaults: { format: 'json'}
  # ASK FOR ID's
  put 'api/admins/:id/edit' => 'admins#edit', defaults: { format: 'json'}
  delete 'api/admins/:id/delete' => 'admins#delete', defaults: { format: 'json'}


  # Appointments
  get 'api/users/:id/appointments' => 'appointments#show', defaults: { format: 'json' }
  get 'api/sp/:id/appointments/upcoming' => 'appointments#spUpcoming', defaults: { format: 'json' }
  get 'api/sp/:id/appointments/past' => 'appointments#spPast', defaults: { format: 'json' }
  put 'api/appointments/:id/pay' => 'appointments#pay', defaults: { format: 'json' }
  put 'api/appointments/:id/complete' => 'appointments#complete', defaults: { format: 'json' }
  put 'api/appointments/:id/cancel' => 'appointments#cancel', defaults: { format: 'json' }
  post 'api/users/:id/appointments' => 'appointments#create', defaults: { format: 'json' }

  get 'api/appointments/upcoming' => 'appointments#upcoming', defaults: { format: 'json' }
  get 'api/appointments/past' => 'appointments#past', defaults: { format: 'json' }
  get 'api/appointments/unassigned' => 'appointments#unassigned', defaults: { format: 'json' }

  post 'api/assignments' => 'assignments#create', defaults: { format: 'json' }

  # Bookings

  post 'api/appointments/bookings/home-cleanings' => 'bookings#home_cleanings', defaults: { format: 'json' }
  post 'api/appointments/bookings/office-cleanings' => 'bookings#office_cleanings', defaults: { format: 'json' }
  post 'api/appointments/bookings/car-washes' => 'bookings#car_washes', defaults: { format: 'json' }
  post 'api/appointments/bookings/drivers' => 'bookings#drivers', defaults: { format: 'json' }
  post 'api/appointments/bookings/securities' => 'bookings#securities', defaults: { format: 'json' }
  post 'api/appointments/bookings/chefs' => 'bookings#chefs', defaults: { format: 'json' }
  post 'api/appointments/bookings/gardenings' => 'bookings#gardenings', defaults: { format: 'json' }
  post 'api/appointments/bookings/contractors' => 'bookings#contractors', defaults: { format: 'json' }

  # Discounts

  post 'api/admins/:id/discounts' => 'discounts#create', defaults: { format: 'json' }
  get 'api/discounts/:id' => 'discounts#validate', defaults: { format: 'json' }

  # Addresses

  post 'api/addresses' => 'addresses#create', defaults: { format: 'json' }
  get 'api/users/:id/addresses' => 'addresses#index', defaults: { format: 'json' }
  delete 'api/addresses/:id/delete' => 'addresses#destroy', defaults: { format: 'json' }

  # Stripe Payments

  post 'api/charges/stripe' => 'charges#create', defaults: { format: 'json' }

  # Contact Emails

  post 'api/mailer/contact' => 'mailers#contact'
  
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
