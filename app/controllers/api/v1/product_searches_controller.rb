module Api
    module V1
        class ProductSearchesController < ActionController::Base
            skip_before_action :verify_authenticity_token

            def reindex
                es_products = ProductSearch.reindex
                render json: {response:es_products,status:true,messages:"successfully reindexing completed"}, status: 200
            end
        
            def search
                products=[]
                es_products = ProductSearch.search_products(params[:query],params[:site_id], limit: 2500, offset: 0)
                es_products.each do |product|
                    products << @service.format_es_product(product)
                end
                render json: {response:products,status:true}, status: 200
            end
        
            def refresh
                product=ProductSearch.refresh
                render json: {response:data,status:true,messages:"successfully product refresh completed"}, status: 200
            end
        
        end
    end
end

