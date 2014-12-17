Rails.application.routes.draw do



  resources :articles

#auth
  get '/auth/:provider/callback' => 'sessions#callback'
  get '/auth/:provider/create' =>'sessions#create'


#MetroHome
  root 'metro#index'
  get  '/metro/article_index' => 'metro#article_index'
  post 'metro/login' => 'metro#login'
  get  '/metro' => 'metro#index', as: :metro_index
  post '/metro/pickup_article/:category' => 'metro#pickup_article'
  get  '/logout' => 'metro#logout'
  get  '/signout' => 'sessions#destroy', :as => :signout
  post '/metro/clip_topic' => 'metro#clip_topic'
  post '/metro/favorite' => 'metro#favorite'
  post '/metro/check/:article_id' => 'metro#check'


  get  '/create_account_form' => 'metro#create_account_form'
  post '/create_account' => 'metro#create_account'


#Read_history
  post '/record' => 'readhistory#record'

#lounge
  #コミュニティ関連
  get  '/lounge' => 'lounge#index'
  get  '/lounge/new' => 'lounge#new_lounge'
  post '/lounge/create' => 'lounge#create_lounge'
  get  '/lounge/show' => 'lounge#show_lounge'
  get  '/lounge/:community_id/edit' => 'lounge#edit_lounge'
  post '/lounge/:community_id/update' => 'lounge#update_lounge'
  get  '/lounge/:community_id' => 'lounge#enter_lounge'
  delete '/lounge/:community_id' => 'lounge#delete_lounge'


  #トッピックス関連
  get  '/lounge/:community_id/new' => 'lounge#new_topics'
  post '/lounge/:community_id' => 'lounge#create_topics'
  delete '/lounge/:community_id/:id' => 'lounge#destroy_topics'


  #コメント関連
  get  '/lounge/:community_id/:id' => 'lounge#comments'
  post '/lounge/:community_id/:id' => 'lounge#create_comment'
  get  '/lounge/:community_id/:id/:comment_id/edit' => 'lounge#edit_comment'
  post '/lounge/:community_id/:id/:comment_id/update' => 'lounge#update_comment'
  delete '/lounge/:community_id/:id/:comment_id/delete' => 'lounge#destroy_comment'


#Visual
  get '/visual' => "visual#index"
  get '/visual/maps' => "visual#map"


#管理
 #account
  get '/account' => 'account#index', as: :account_index
  get '/get_salesforce_member' => 'account#get_salesforce_member', as: :account_get

 #article
  get  '/articlescrawl' => "articles#crawl"
  get  '/reset' => "articles#resetArticle"
  post '/send_to_salesforce' => "articles#send_to_salesforce"
  get  '/send_read_info' => 'articles#send_read_info'
  get  '/articles/twitter/:id' => 'articles#twitter', as: :twitter
  get  '/rt_search' => 'articles#rt_search'
  get  '/rt_search_all' => 'articles#rt_search_all'
  post '/favorite' =>  'articles#favorite'


#old
  get  '/welcome' => 'welcome#index'


  #root :to => 'test#index'

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
