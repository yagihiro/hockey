require_relative 'app'
require_relative 'networking'

module Hockey

  # HockeyApp API Client for Application
  class Client

    #
    def initialize(token, debug:false)
      @net = Networking.new token, debug:debug
      @apps = nil
      @teams = nil
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

    # return Array of Team objects
    def teams
      return @teams if @teams

      @teams = []
      page = 1

      while true
        obj = @net.get_object('/api/2/teams') do |req|
          req.params[:page] = page
        end
        obj['teams'].each do |hashobj|
          @teams << Team.create_from(hashobj, @net)
        end

        total = obj['total_pages'].to_i
        break unless page < total

        page = page + 1
      end

      @teams
    end

    # create new app on HockeyApp
    def new_app(title:title, bundle_identifier:bundle_identifier, platform: 'iOS')
      obj = @net.post_object '/api/2/apps/new', {:title=>title, :bundle_identifier=>bundle_identifier, :platform=>platform, :release_type=>0}

      app = App.create_from(obj, @net)

      app
    end

  end

end
