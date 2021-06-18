
class MerchantSnapDatum < ElasticModel
  searchkick index_name: "merchant_snap_data_#{Rails.env}"
  index_name "merchant_snap_data_#{Rails.env}"
  self.primary_key = :id
  self.search_klass = 'MerchantSnapDatum'
  # @mcp_es_connection =  ElasticSearch::Base.connection("mcp")

  settings index: { number_of_shards: 1 } do
    document_type 'merchant_snap_data'
    mappings dynamic: 'false' do
      indexes :merchant_id, analyzer: 'english', index_options: 'offsets'
      indexes :data, analyzer: 'english'
    end
  end

  def self.get_data(merchant_id)
    # es_connection
    options = {
    fields: [:merchant_id],
    where: {merchant_id:merchant_id }}
    MerchantSnapDatum.search(options)
  end

  def as_indexed_json
    self.as_json
  end

  # def self.es_connection
  #   Searchkick.client = @mcp_es_connection
  # end

end
