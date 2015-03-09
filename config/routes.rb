Rails.application.routes.draw do
  get 'sessions/new'

  root 'welcome#index'
  #get 'about' => 'welcome#about'
  get 'vision' => 'welcome#vision'
  get 'curriculum' => 'welcome#curriculum'
  get 'team' => 'welcome#team'
  get 'dates' => 'welcome#dates'
  get 'financial' => 'welcome#financial'
  get 'faq' => 'welcome#faq'
  get 'apply' => 'welcome#apply'
  get 'signup' => 'applicants#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get 'users/:user_id/apps/:id/edit/:page' => 'apps#edit'

  get 'join_our_team' => 'welcome#join_our_team'
  get 'recommender_dashboard' => 'recommenders#index_applicants'
  get 'users/reset-password' => 'users#reset_password_form'
  post 'users/reset-password' => 'users#reset_password'

  get 'admin_panel' => 'welcome#admin_panel'
  post 'create_admin' => 'users#create_admin'
  post 'applicants/email_all' => 'applicants#email_all'

  resources :users

  resources :applicants do
    resources :apps
  end

  resources :recommenders

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

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
