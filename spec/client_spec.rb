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

    before do
      @page1 =<<_EOS_
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
      @page2 =<<_EOS_
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
    end

    it 'when succeeded' do
      net_mock = Minitest::Mock.new
      client = Hockey::Client.new 'token', network: net_mock

      net_mock.expect(:get_object, JSON.parse(@page1), ['/api/2/teams'])
      teams = client.teams
      teams.must_be_kind_of Hockey::PagingArray
      teams.size.must_equal 2
      teams.each do |obj|
        obj.must_be_instance_of Hockey::Team
      end
      teams[0].id.must_equal 23
      teams[1].id.must_equal 42
      net_mock.verify
    end

    it 'when success w/ paging' do
      net_mock = Minitest::Mock.new
      client = Hockey::Client.new 'token', network: net_mock

      net_mock.expect(:get_object, JSON.parse(@page1), ['/api/2/teams'])
      teams = client.teams(page: 1)
      teams.must_be_kind_of Hockey::PagingArray
      teams.size.must_equal 2
      teams.each do |obj|
        obj.must_be_instance_of Hockey::Team
      end
      teams[0].id.must_equal 23
      teams[1].id.must_equal 42
      teams.current_page.must_equal 1
      teams.total_entries.must_equal 3
      teams.total_pages.must_equal 2

      net_mock.expect(:get_object, JSON.parse(@page2), ['/api/2/teams'])
      teams = client.teams(page: 2)
      teams.must_be_kind_of Hockey::PagingArray
      teams.size.must_equal 1
      teams.each do |obj|
        obj.must_be_instance_of Hockey::Team
      end
      teams[0].id.must_equal 50
      teams.current_page.must_equal 2
      teams.total_entries.must_equal 3
      teams.total_pages.must_equal 2

      net_mock.verify
    end

  end

end

