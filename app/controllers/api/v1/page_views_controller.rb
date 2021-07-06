module Api
    module V1
        class PageViewsController < ActionController::Base

            skip_before_action :verify_authenticity_token

            def reindex
                data = PageView.reindex 
                render json: {response:data,status:true,messages:"successfully reindexing completed"}, status: 200
            end
            def update
                page_view = PageView.find_by_merchant_id(params[:query][:merchant_id])
                page_view.update_columns(merchant_id: params[:data])
                render json: page_view.to_json, status: 200
            end
            def destory
                page_view = PageView.find_by_merchant_id(params[:query][:merchant_id])
                page_view.delete
                render json: {status:true,messages:"page view data deleted successfully"}, status: 200
            end
            def search
                page_view = PageView.get_data(params[:query][:merchant_id])
                render json: {response:page_view,status:true}, status: 200
            end
            def create 
                data = PageView.create(params[:query])
                render json: {response:data,status:true}, status: 200
            end
        end
    end
end
