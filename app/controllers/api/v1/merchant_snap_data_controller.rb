module Api
    module V1
        class MerchantSnapDataController < ActionController::Base

            skip_before_action :verify_authenticity_token

            def reindex
                data = MerchantSnapDatum.reindex
                render json: {response:data,status:true,messages:"successfully reindexing completed"}, status: 200
            end
            def update
                merchant_snap_data = MerchantSnapDatum.find_by_merchant_id(params[:query])
                merchant_snap_data.update_columns(merchant_id: params[:data])
                render json: {response:merchant_snap_data,status:true}, status: 200
            end
            def destory
                merchant_snap_data = MerchantSnapDatum.find_by_merchant_id(params[:query])
                merchant_snap_data.delete
                render json: {status:true,messages:"merchant snap data deleted successfully"}, status: 200
            end
            def search
                merchant_snap_data = MerchantSnapDatum.get_data(params[:query][:merchant_id])
                render json: {response:merchant_snap_data,status:true}, status: 200
            end
            def create 
                data = MerchantSnapDatum.create(params[:query])
                render json: {response:data,status:true}, status: 200
            end
        end
    end
end
