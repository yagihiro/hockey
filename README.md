# hockeyhelper gem

Helper gem for HokceyApp API.

[![Build Status](https://travis-ci.org/yagihiro/hockey.svg?branch=master)](https://travis-ci.org/yagihiro/hockey)
[![Gem Version](https://badge.fury.io/rb/hockeyhelper.svg)](http://badge.fury.io/rb/hockeyhelper)

## Installation

Add this line to your application's Gemfile:

    gem 'hockeyhelper'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hockeyhelper

## Usage

create a new app and an invite user

```ruby
require 'hockeyhelper'
client = Hockey::Client.new 'yourapitoken'
app = client.new_app(title: appname, bundle_identifier: bundleid, platform: platform)
user = app.invite_user(email: email)
```

list all apps with paging

```ruby
require 'hockeyhelper'
client = Hockey::Client.new 'yourapitoken'
apps = client.apps(page: 1)
```

list all versions for an app

```ruby
require 'hockeyhelper'
client = Hockey::Client.new 'yourapitoken'
versions = client.apps(page: 1)[0].versions
```

list all users for an app

```ruby
require 'hockeyhelper'
client = Hockey::Client.new 'yourapitoken'
users = client.apps(page: 1)[0].users
```

remove a user from an app

```ruby
require 'hockeyhelper'
client = Hockey::Client.new 'yourapitoken'
client.apps(page: 1)[0].remove_user 'email@xxx.xx'
```

list all teams with paging

```ruby
require 'hockeyhelper'
client = Hockey::Client.new 'yourapitoken'
teams = client.teams(page: 1)
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/hockey/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
