module Hockey

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

    attr :net

    def self.create_from(hashobj, networking)
      self.new hashobj, networking
    end

    def initialize(hashobj, networking)
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
      @versions = nil
    end

    def inspect
      "#{@title}, #{@bundle_identifier}, #{@platform}, #{@public_identifier}"
    end
    alias_method :to_s, :inspect

    # List all users of an app on HockeyApp.
    # return an Array of User objects.
    def users
      return @users if @users

      obj = @net.get_object "/api/2/apps/#{@public_identifier}/app_users"

      @users = []
      obj['app_users'].each do |hashobj|
        @users << User.create_from(hashobj, @net)
      end

      @users
    end

    # Invite a user to an app.
    # return a User object.
    def invite_user(email:email)
      obj = @net.post_object "/api/2/apps/#{@public_identifier}/app_users", {:email=>email, :role=>1}

      user = User.create_from(obj, @net)

      user
    end

    # Remove a user from an app on HockeyApp.
    def remove_user(email:nil)
      users()
      user = @users.find {|u| u.email == email }

      if user
        @net.delete "/api/2/apps/#{@public_identifier}/app_users/#{user.id}"
      end
    end

    # List all versions of an app. The endpoint returns all versions for developer and members, but only released versions for testers.
    # return an Array of Version objects.
    def versions
      return @versions if @versions

      obj = @net.get_object "/api/2/apps/#{@public_identifier}/app_versions"

      @versions = []
      obj['app_versions'].each do |hashobj|
        @versions << Version.create_from(hashobj, @net)
      end

      @versions
    end

    # List all crash groups for an app.
    # return an Array of CrashReason objects.
    #
    # +sort+ parameter:
    #   :date, :class, :number_of_crashes, :last_crash_at
    # +order+ parameter:
    #   :asc, :desc
    def crash_reasons(page: 1, per: 25, symbolicated: true, sort: :date, order: :asc)
      obj = @net.get_object "/api/2/apps/#{@public_identifier}/crash_reasons"

      cr = []
      obj['crash_reasons'].each do |hashobj|
        cr << CrashReason.create_from(hashobj, @net)
      end

      cr
    end

  end

end