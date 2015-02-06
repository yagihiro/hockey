require_relative 'app'
require_relative 'networking'

module Hockey

  # HockeyApp API Client for Application
  class Client

    #
    def initialize(token, debug:false)
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

    # create new app on HockeyApp
    def new_app(title:title, bundle_identifier:bundle_identifier, platform: 'iOS')
      obj = @net.post_object '/api/2/apps/new', {:title=>title, :bundle_identifier=>bundle_identifier, :platform=>platform, :release_type=>0}

      app = App.create_from(obj, @net)

      app
    end

  end

end
