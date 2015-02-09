module Hockey

  # CrashReason on HockeyApp
  class CrashReason

    attr_reader :id
    attr_reader :app_id
    attr_reader :app_version_id
    attr_reader :number_of_crashes
    attr_reader :created_at
    attr_reader :updated_at
    attr_reader :last_crash_at
    attr_reader :bundle_short_version
    attr_reader :bundle_version
    attr_reader :status
    attr_reader :fixed
    attr_reader :file
    attr_reader :crash_class
    attr_reader :crash_method
    attr_reader :line
    attr_reader :reason
    attr_reader :original_hash

    attr :net

    def self.create_from(hashobj, networking)
      self.new hashobj, networking
    end

    def initialize(hashobj, networking)
      @id = hashobj['id']
      @app_id = hashobj['app_id']
      @app_version_id = hashobj['app_version_id']
      @number_of_crashes = hashobj['number_of_crashes']
      @created_at = hashobj['created_at']
      @updated_at = hashobj['updated_at']
      @last_crash_at = hashobj['last_crash_at']
      @bundle_short_version = hashobj['bundle_short_version']
      @bundle_version = hashobj['bundle_version']
      @status = hashobj['status']
      @fixed = hashobj['fixed']
      @file = hashobj['file']
      @crash_class = hashobj['class']
      @crash_method = hashobj['method']
      @line = hashobj['line']
      @reason = hashobj['reason']
      @original_hash = hashobj
      @net = networking
    end

    def inspect
      "#<#{self.class}:#{'0x%08x' % self.hash} #{@id}, #{@file}, #{@crash_class}, #{@crash_method}, #{@line}>"
    end
    alias_method :to_s, :inspect

  end

end