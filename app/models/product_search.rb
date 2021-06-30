
class ProductSearch < ElasticModel

  searchkick index_name: "shpmtc_product_searches_#{Rails.env}"
  index_name "shpmtp_product_searches_#{Rails.env}"
  self.primary_key = :id
  self.search_klass = 'Product'
  #@primary_es_connection = ElasticSearch::Base.connection("primary")
  settings index: { number_of_shards: 1 } do
    document_type 'product_search'
    mappings dynamic: 'false' do
      indexes :product_name, analyzer: 'english', index_options: 'offsets'
      indexes :category_name, analyzer: 'english'
      indexes :sku, analyzer: 'english'
      indexes :canonical_name, analyzer: 'english'
      indexes :variant_names, analyzer: 'english'
      indexes :description, analyzer: 'english', index: :no
    end
  end

  def self.search_products(query, site_id, limit: 25, offset: 0)
    options = {
      load: false,
      fields: ['product_name^10', 'category_name^8', 'variant_names^8', 'sku^7', 'canonical_name^6'],
      where: { site_id: site_id, status: 1 },
      misspellings: { below: 3, edit_distance: 2 },
      limit: limit.to_i,
      offset: offset.to_i
    }
    # es_connection
    response = ProductSearch.search(query, options).response
    total = response['hits']['total']
    response['hits']['hits'].map { |res| Search::ProductResponse.new(res["_id"], res["_source"], total_count: total) }
  end

  #def self.es_connection
  #  Searchkick.client = @primary_es_connection
  #end

  def self.refresh
    #es_connection
    Searchkick.redis = ConnectionPool.new { Redis.current }
    ids_to_reindex = Redis.current.smembers(updated_product_ids_set)
    if ids_to_reindex.present?
      delta_index(id: ids_to_reindex)
      push_to_redis(ids_to_reindex)
      Redis.current.srem(updated_product_ids_set, ids_to_reindex)
    end
    ProductSearch::ReindexCleanupJob.set(wait: 3.minutes).perform_later
  end

  def self.push_to_redis(ids_to_reindex)
    time = Time.now.to_i
    Redis.current.sadd(time, ids_to_reindex)
    Redis.current.lpush(processed_jobs_timestamps, time)
  end

  def self.updated_product_ids_set
    'searckick-products-ids'
  end

  def self.processed_jobs_timestamps
    'products-ids-searckick-reindexed'
  end

end
