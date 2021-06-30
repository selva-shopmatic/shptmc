class PageViewsController < ActionController::Base

    skip_before_action :verify_authenticity_token

    def reindex
        data = PageView.get_data(params[:query]).results rescue []
        render json: {messages: "successfully reindex completed"}, status: 200
    end
    def update
        page_view = PageView.find_by_merchant_id(params[:query])
        page_view.update_columns(merchant_id: params[:data])
        render json: page_view.to_json, status: 200
    end
    def destory
        page_view = PageView.find_by_merchant_id(params[:query])
        page_view.delete
        render json: {messages:'successfully deleted'}, status: 200
    end
    def search
        page_view = PageView.find_by_merchant_id(params[:query])
        render json: page_view.to_json, status: 200
    end
    def create 
        data = PageView.create(params[:query])
        render json: data.to_json, status: 200
    end
end
