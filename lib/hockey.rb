require 'hockey/version'
require 'faraday'
require 'json'

module Hockey

  class Hockey

    #
    def initialize token
      @client = Faraday.new(:url => 'https://rink.hockeyapp.net')
      @token = token
      @apps = nil
    end

    def each_apps
      return @apps if @apps

      res = @client.get do |req|
        req.url '/api/2/apps'
        req.headers['X-HockeyAppToken'] = @token
      end

      @apps = JSON.parse res.body

      yield @apps if block_given?

      @apps
    end

    def each_app_id
      each_apps

      @apps['apps'].each do |app|
        yield app['public_identifier']
      end
    end

    def each_users app_id
      res = @client.get do |req|
        req.url "/api/2/apps/#{app_id}/app_users"
        req.headers['X-HockeyAppToken'] = @token
      end

      users = JSON.parse res.body
      yield users if block_given?

      users
    end

  end

end
