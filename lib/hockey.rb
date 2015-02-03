require 'hockey/version'
require 'faraday'
require 'json'

module Hockey

  #
  def initialize token
    @client = Faraday.new(:url => 'https://rink.hockeyapp.net')
    @token = token
    @apps = nil
  end

end
