module Hockey

  VERSION = '0.0.6'

  # Version on HockeyApp
  class Version

    attr_reader :version
    attr_reader :mandatory
    attr_reader :config_url
    attr_reader :download_url
    attr_reader :timestamp
    attr_reader :appsize
    attr_reader :device_family
    attr_reader :notes
    attr_reader :status
    attr_reader :shortversion
    attr_reader :minimum_os_version
    attr_reader :title
    attr_reader :original_hash
    attr :net

    def self.create_from(hashobj, networking)
      self.new hashobj, networking
    end

    def initialize(hashobj, networking)
      @version = hashobj['version']
      @mandatory = hashobj['mandatory']
      @config_url = hashobj['config_url']
      @download_url = hashobj['download_url']
      @timestamp = hashobj['timestamp']
      @appsize = hashobj['appsize']
      @device_family = hashobj['device_family']
      @notes = hashobj['notes']
      @status = hashobj['status']
      @shortversion = hashobj['shortversion']
      @minimum_os_version = hashobj['minimum_os_version']
      @title = hashobj['title']
      @original_hash = hashobj
      @net = networking
    end

    def inspect
      "#{@title} #{@version}"
    end
    alias_method :to_s, :inspect

  end


end
