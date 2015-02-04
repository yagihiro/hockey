require 'faraday'
require 'hockey/version'
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
      @l.info "get #{path}"

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
      @l.info "delete #{path}"

      response = @client.delete do |req|
        req.url path
        req.headers['X-HockeyAppToken'] = @token
      end

      response
    end

  end

  # User on HockeyApp
  class User

    attr_reader :role
    attr_reader :id
    attr_reader :user_id
    attr_reader :full_name
    attr_reader :email
    attr_reader :invited_at
    attr_reader :original_hash

    attr :net

    def self.create_from hashobj, networking
      self.new hashobj, networking
    end

    def initialize hashobj, networking
      @role = hashobj['role']
      @id = hashobj['id']
      @user_id = hashobj['user_id']
      @full_name = hashobj['full_name']
      @email = hashobj['email']
      @invited_at = hashobj['invited_at']
      @original_hash = hashobj
      @net = networking
    end

    def inspect
      "#{@user_id}, #{@full_name}, #{@email}"
    end
    alias_method :to_s, :inspect

  end

  # App on HockeyApp
  class App

    attr_reader :title
    attr_reader :bundle_identifier
    attr_reader :public_identifier
    attr_reader :device_family
    attr_reader :minimum_os_version
    attr_reader :release_type
    attr_reader :status
    attr_reader :platform
    attr_reader :original_hash

    attr :net, :users

    def self.create_from hashobj, networking
      self.new hashobj, networking
    end

    def initialize hashobj, networking
      @title = hashobj['title']
      @bundle_identifier = hashobj['bundle_identifier']
      @public_identifier = hashobj['public_identifier']
      @device_family = hashobj['device_family']
      @minimum_os_version = hashobj['minimum_os_version']
      @release_type = hashobj['release_type']
      @status = hashobj['status']
      @platform = hashobj['platform']
      @original_hash = hashobj
      @net = networking
      @users = nil
    end

    def inspect
      "#{@title}, #{@bundle_identifier}, #{@platform}, #{@public_identifier}"
    end
    alias_method :to_s, :inspect

    def remove_user email:nil
      users()
      user = @users.find {|u| u.email == email }

      if user
        @net.delete "/api/2/apps/#{@public_identifier}/app_users/#{user.id}"
      end
    end

    def users
      return @users if @users

      obj = @net.get_object "/api/2/apps/#{@public_identifier}/app_users"

      @users = []
      obj['app_users'].each do |hashobj|
        @users << User.create_from(hashobj, @net)
      end

      @users
    end

  end

  # HockeyApp API Client for Application
  class Client

    #
    def initialize token, debug:false
      @net = Networking.new token, debug:debug
      @apps = nil
    end

    # return Array of App objects
    def apps
      return @apps if @apps

      obj = @net.get_object '/api/2/apps'

      @apps = []
      obj['apps'].each do |hashobj|
        @apps << App.create_from(hashobj, @net)
      end

      @apps
    end

  end

end
