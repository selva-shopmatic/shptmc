class ProductSearchesController < ActionController::Base
    def index
        products=[]
        es_products = ProductSearch.search_products(params[:query],params[:site_id], limit: 2500, offset: 0)
        es_products.each do |product|
            products << @service.format_es_product(product)
        end
        render json: products.to_json, status: 200
    end
    def update
    end
    def destory
    end
    def show
    end
end
