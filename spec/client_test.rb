require 'minitest/autorun'
require 'hockeyhelper'

describe Hockey::Client do

  describe 'initialize' do

    it 'when no argument' do
      proc { Hockey::Client.new }.must_raise(ArgumentError)
    end

    it 'when specified an argument' do
      proc { Hockey::Client.new(1) }.must_raise(ArgumentError)

      client = Hockey::Client.new ''
      client.must_be_instance_of Hockey::Client
    end

  end

  describe 'teams' do

    it 'when succeeded' do
      # todo: mocking
      # client = Hockey::Client.new ''
      # teams = client.teams
      # teams.must_be_instance_of Array
    end

  end

end

