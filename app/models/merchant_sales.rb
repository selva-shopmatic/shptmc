class MerchantSales < ElasticModel
  searchkick index_name: "merchant_sales_#{Rails.env}"
  index_name "merchant_sales_#{Rails.env}"
  self.primary_key = :id
  self.search_klass = 'MerchantSales'

  scope :all_confirmed_last_week_orders, -> { where(' order_date >= :start_date and order_date <= :end_date' ,start_date: "%#{ Time.now.utc - 7.days }%",  end_date: "%#{ Time.now.utc }%")}

  settings index: { number_of_shards: 1 } do
    document_type 'merchant_sales'
    mappings dynamic: 'false' do
      indexes :merchant_id, analyzer: 'english', index_options: 'offsets'
      indexes :order_id, analyzer: 'english'
      indexes :order_date, analyzer: 'english'
      indexes :channel, analyzer: 'english'
      indexes :order_value, analyzer: 'english'
      indexes :order_type, analyzer: 'english'
    end
  end

  def self.get_data(query)
    begin
      options = {
      fields: [:order_id, :order_date, :merchant_id, :channel, :order_value,:range],
      where: query[:where],
      order: {order_date: :desc},
      aggs: query[:aggs]}
      MerchantSales.search(options)
      rescue  => error
        puts error
        MerchantSales.reindex
        MerchantSales.search(options) 
    end
  end

  def as_indexed_json
    self.as_json
  end

end