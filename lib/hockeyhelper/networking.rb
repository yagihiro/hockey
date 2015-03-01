require 'faraday'
require 'json'
require 'logger'

module Hockey

  class NullLogger < Logger
    def initialize *args
    end
    def debug(*args); end
    def info(*args); end
    def warn(*args); end
    def error(*args); end
    def fatal(*args); end
  end

  # Networking Core Lib
  class Networking

    attr :l

    def initialize(token, debug: false)
      raise(ArgumentError, 'token must be an instance of String') unless token.kind_of?(String)

      @client = Faraday.new(:url => 'https://rink.hockeyapp.net')
      @token = token
      @l = if debug
             Logger.new(STDOUT)
           else
             NullLogger.new
           end
    end

    # The http wrapper for GET method to the HockayApp.
    # you might give a block object if necessary.
    def get(path)
      @l.info "GET #{path}"

      response = @client.get do |req|
        req.url path
        req.headers['X-HockeyAppToken'] = @token
        yield req if block_given?
      end

      response
    end

    # The http wrapper for GET method to the HockayApp.
    # you might give a block object if necessary.
    # see the #get method
    #
    # Return the Hash object from response json.
    def get_object(path)
      response = get(path)
      JSON.parse(response.body) || {}
    end

    # The http wrapper for POST method to the HockayApp.
    def post(path, bodyhash)
      @l.info "POST #{path}, #{bodyhash}"

      response = @client.post do |req|
        req.url path
        req.headers['X-HockeyAppToken'] = @token
        req.body = bodyhash
      end

      response
    end

    def post_object(path, bodyhash)
      response = post path, bodyhash
      JSON.parse(response.body) || {}
    end

    def delete(path)
      @l.info "DELETE #{path}"

      response = @client.delete do |req|
        req.url path
        req.headers['X-HockeyAppToken'] = @token
      end

      response
    end

  end

end