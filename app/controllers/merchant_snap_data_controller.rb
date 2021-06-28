class MerchantSnapDataController < ActionController::Base

    skip_before_action :verify_authenticity_token

    def index
        data = MerchantSnapDatum.get_data(params[:query]).results
        render json: data.to_json, status: 200
    end
    def update
        merchant_snap_data = MerchantSnapDatum.find_by_merchant_id(params[:query])
        merchant_snap_data.update_columns(merchant_id: params[:data])
        render json: merchant_snap_data.to_json, status: 200
    end
    def destory
        merchant_snap_data = MerchantSnapDatum.find_by_merchant_id(params[:query])
        merchant_snap_data.delete
        render json: {messages:'successfully deleted'}, status: 200
    end
    def show
        merchant_snap_data = MerchantSnapDatum.find_by_merchant_id(params[:query])
        render json: merchant_snap_data.to_json, status: 200
    end
end
