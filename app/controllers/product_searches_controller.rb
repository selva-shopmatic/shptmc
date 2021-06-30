class ProductSearchesController < ActionController::Base
    def reindex
        products=[]
        es_products = ProductSearch.reindex
        render json: {messages: "successfully reindex completed"}, status: 200
    end

    def search
        products=[]
        es_products = ProductSearch.search_products(params[:query],params[:site_id], limit: 2500, offset: 0)
        es_products.each do |product|
            products << @service.format_es_product(product)
        end
        render json: products.to_json, status: 200
    end

    def refresh
        product=ProductSearch.refresh
        render json: {messages: "successfully product refresh completed"}, status: 200
    end

end
