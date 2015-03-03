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
      net_mock = Minitest::Mock.new
      client = Hockey::Client.new 'token', network: net_mock

      object =<<_EOS_
{
    "teams": [
        {
            "id": 23,
            "name": "Bit Stadium GmbH Owners"
        },
        {
            "id": 42,
            "name": "External Testers"
        }
    ],
    "status": "success",
    "current_page": 1,
    "per_page": 25,
    "total_entries": 3,
    "total_pages": 2
}
_EOS_
      net_mock.expect(:get_object, JSON.parse(object), ['/api/2/teams'])
      object =<<_EOS_
{
    "teams": [
        {
            "id": 50,
            "name": "Bit Stadium GmbH Owners"
        }
    ],
    "status": "success",
    "current_page": 2,
    "per_page": 25,
    "total_entries": 3,
    "total_pages": 2
}
_EOS_
      net_mock.expect(:get_object, JSON.parse(object), ['/api/2/teams'])

      teams = client.teams
      teams.must_be_instance_of Array
      teams.size.must_equal 3
      teams.each do |obj|
        obj.must_be_instance_of Hockey::Team
      end
      teams[0].id.must_equal 23
      teams[1].id.must_equal 42
      teams[2].id.must_equal 50
      net_mock.verify
    end

  end

end

