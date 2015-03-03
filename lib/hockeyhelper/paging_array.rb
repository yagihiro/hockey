module Hockey

  class PagingArray < Array
    attr_reader :current_page
    attr_reader :per_page         # = 25
    attr_reader :total_entries
    attr_reader :total_pages

    def initialize
      super
      @per_page = 25
    end

    def update_page(hashobj)
      @current_page  = hashobj['current_page'].to_i
      @total_entries = hashobj['total_entries'].to_i
      @total_pages   = hashobj['total_pages'].to_i

      self
    end

  end

  class OrderedPagingArray < PagingArray
    attr :order_type
  end

  class ClashesPagingArray < OrderedPagingArray
    attr :symbolicated
    attr :sort_type
  end

end