class MerchantSalesController < ActionController::Base

    skip_before_action :verify_authenticity_token

    def index
        data = MerchantSales.get_data(params[:query]).results
        render json: data.to_json, status: 200
    end
end
