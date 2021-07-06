module Api
    module V1
        class MerchantSalesController < ActionController::Base

            skip_before_action :verify_authenticity_token

            def reindex
                data = MerchantSales.reindex
                render json: {response:data,status:true,messages:"successfully reindexing completed"}, status: 200
            end

            def search 
                data = MerchantSales.get_data(params[:query]).results
                render json: {response:data,status:true}, status: 200
            end
        end
    end
end
