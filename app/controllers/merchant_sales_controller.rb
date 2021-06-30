class MerchantSalesController < ActionController::Base

    skip_before_action :verify_authenticity_token

    def reindex
        data = MerchantSales.reindex
        render json: {messages: "successfully reindex completed"}, status: 200
    end

    def search 
        data = MerchantSales.get_data(params[:query]).results
        render json: data.to_json, status: 200
    end
end
