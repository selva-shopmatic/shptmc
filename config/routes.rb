Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do

      namespace :product_search do
        post "search" => "product_searches#search"
        post "reindex" => "product_searches#reindex"
        post "refresh" => "product_searches#refresh"
      end

      namespace :merchant_snap_data do
        post "search" => "merchant_snap_data#search"
        post "reindex" => "merchant_snap_data#reindex"
        post "update" => "merchant_snap_data#update"
        post "create" => "merchant_snap_data#update"
        post "delete" => "merchant_snap_data#delete"
      end

      namespace :merchant_sales do
        post "search" => "merchant_sales#search"
        post "reindex" => "merchant_sales#reindex"
      end

      namespace :page_views do
        post "search" => "page_view#search"
        post "reindex" => "page_view#reindex"
        post "update" => "page_view#update"
        post "create" => "page_view#update"
        post "delete" => "page_view#delete"
      end

    end
  end
end
