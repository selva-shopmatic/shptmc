Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :product_searches
  resources :merchant_snap_data
  resources :page_views
  resources :merchant_sales
end
