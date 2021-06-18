class PageView < ElasticModel
  searchkick index_name: "page_views_#{Rails.env}"
  index_name "page_views_#{Rails.env}"
  self.primary_key = :id
  self.search_klass = 'PageView'

  # @primary_es_connection =  ElasticSearch::Base.connection("primary")

  settings index: { number_of_shards: 1 } do
    document_type 'page_views'
    mappings  do
      indexes :merchant,  analyzer: 'english'
      indexes :id,   analyzer: 'english'
      indexes :data,   type: 'object'
    end
  end

  def self.get_data(merchant_id)
    # es_connection
    data = (PageView.search body:  {
              "query": {
                "bool": { "filter": [
                    { "term": {"merchant_id": merchant_id } }
                  ]
                }}
            } ) rescue {}
    results = data.response["hits"]['hits'].first['_source'] rescue []
  end

  # def self.es_connection
  #   Searchkick.client = @primary_es_connection
  # end
  
end
  