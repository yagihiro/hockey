require 'faraday'
require 'json'
require 'logger'

module Hockey

  class NullLogger < Logger
    def initialize *args
    end
    def debug; end
    def info; end
    def warn; end
    def error; end
    def fatal; end
  end

  # Networking Core Lib
  class Networking

    attr :l

    def initialize token, debug:false
      @client = Faraday.new(:url => 'https://rink.hockeyapp.net')
      @token = token
      @l = if debug
             Logger.new(STDOUT)
           else
             NullLogger.new
           end
    end

    def get path
      @l.info "GET #{path}"

      response = @client.get do |req|
        req.url path
        req.headers['X-HockeyAppToken'] = @token
      end

      response
    end

    def get_object path
      response = get path
      JSON.parse(response.body) || {}
    end

    def delete path
      @l.info "DELETE #{path}"

      response = @client.delete do |req|
        req.url path
        req.headers['X-HockeyAppToken'] = @token
      end

      response
    end

  end

end