require_relative 'app'
require_relative 'networking'
require_relative 'paging_array'

module Hockey

  # HockeyApp API Client for Application
  class Client

    #
    def initialize(token, debug: false, network: nil)
      @net = network || Networking.new(token, debug:debug)
      @apps = nil
      @teams = nil
    end

    # List all apps for the logged user, including owned apps, developer apps, member apps, and tester apps on HockeyApp.
    # return Array of App objects.
    def apps
      return @apps if @apps

      obj = @net.get_object '/api/2/apps'

      @apps = []
      obj['apps'].each do |hashobj|
        @apps << App.create_from(hashobj, @net)
      end

      @apps
    end

    # List all teams for an account.
    #
    # @return [Array] of {Team} objects
    # @param page [Fixnum] optional, used for pagination
    def teams(page: 1)
      teams = PagingArray.new

      obj = @net.get_object('/api/2/teams') do |req|
        req.params[:page] = page
      end
      obj['teams'].each do |hashobj|
        teams << Team.create_from(hashobj, @net)
      end

      teams.update_page(obj)

      teams
    end

    # Create a new app without uploading a file on HockeyApp.
    # return an App object.
    def new_app(title:, bundle_identifier:, platform: 'iOS')
      obj = @net.post_object '/api/2/apps/new', {:title=>title, :bundle_identifier=>bundle_identifier, :platform=>platform, :release_type=>0}

      app = App.create_from(obj, @net)

      app
    end

  end

end
