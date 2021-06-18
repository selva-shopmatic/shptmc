module Search::ElasticSearchIndexer

    def search_klass=(klass=nil)
      @search_klass = (klass&.constantize || self)
    end
  
    def search_klass
      @search_klass
    end
  
    def delta_index(condition, options={:batch_size=>1000})
      without_tenant do
        search_klass.includes(search_klass&.includes_to_index||{}).where(condition).find_in_batches(options).with_index do |object_batch, index|
          bulk_index(object_batch)
        end
      end
    end
  
    def without_tenant(&block)
      Apartment.without_multi_tenant do
        begin
          RequestStore.store[:disable_creating_tenant] = true
          block.call
        ensure
          RequestStore.store[:disable_creating_tenant] = nil
        end
      end
    end
  
    def bulk_index(objects)
      indexed_json = prepare_records(objects)
      if indexed_json.present?
        self.__elasticsearch__.client.bulk({
          index: self.__elasticsearch__.index_name,
          type: self.__elasticsearch__.document_type,
          body: indexed_json
        })
      end
    end
  
    def create_index(alias_name)
      created = self.__elasticsearch__.create_index! index: alias_name
      self.__elasticsearch__.client.indices.put_alias index: alias_name, name: self.__elasticsearch__.index_name if !created.nil?
    end
  
    def prepare_records(objects)
      indexed_json = []
      objects.each{|object|
        begin
          indexed_json << { index: { _id: object.id, data: object.as_indexed_json } }
        rescue => e
        end
      }
      indexed_json
    end
  
  end
  