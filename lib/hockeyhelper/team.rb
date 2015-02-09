module Hockey

  # Team on HockeyApp
  class Team

    attr_reader :id
    attr_reader :name
    attr_reader :original_hash

    attr :net

    def self.create_from(hashobj, networking)
      self.new hashobj, networking
    end

    def initialize(hashobj, networking)
      @id = hashobj['id']
      @name = hashobj['name']
      @original_hash = hashobj
      @net = networking
    end

    def inspect
      "#<#{self.class}:#{'0x%08x' % self.hash} #{@id}, #{@name}>"
    end
    alias_method :to_s, :inspect

  end

end