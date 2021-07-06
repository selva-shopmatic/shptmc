Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
        post "product_searches/search" => "product_searches#search"
        post "product_searches/reindex" => "product_searches#reindex"
        post "product_searches/refresh" => "product_searches#refresh"
        
        post "merchant_snap_data/search" => "merchant_snap_data#search"
        post "merchant_snap_data/reindex" => "merchant_snap_data#reindex"
        post "merchant_snap_data/update" => "merchant_snap_data#update"
        post "merchant_snap_data/create" => "merchant_snap_data#update"
        post "merchant_snap_data/delete" => "merchant_snap_data#delete"

        post "merchant_sales/search" => "merchant_sales#search"
        post "merchant_sales/reindex" => "merchant_sales#reindex"

        post "page_views/search" => "page_views#search"
        post "page_views/reindex" => "page_views#reindex"
        post "page_views/update" => "page_views#update"
        post "page_views/create" => "page_views#update"
        post "page_views/delete" => "page_views#delete"

    end
  end
end
