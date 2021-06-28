module Search
  class ProductResponse
    attr_accessor :id, :source, :total_count

    def initialize(id, source = {}, total_count:)
      @id = id
      @source = source
      @total_count = total_count
    end

  end
end
