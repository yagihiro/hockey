module Hockey

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

end