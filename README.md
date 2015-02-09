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

    require 'hockeyhelper'
    client = Hockey::Client.new 'yourapitoken'
    app = client.new_app(title: appname, bundle_identifier: bundleid, platform: platform)
    user = app.invite_user(email: email)

list all apps

    require 'hockeyhelper'
    client = Hockey::Client.new 'yourapitoken'
    apps = client.apps

list all versions for an app

    require 'hockeyhelper'
    client = Hockey::Client.new 'yourapitoken'
    versions = client.apps[0].versions

list all users for an app

    require 'hockeyhelper'
    client = Hockey::Client.new 'yourapitoken'
    users = client.apps[0].users

remove a user from an app

    require 'hockeyhelper'
    client = Hockey::Client.new 'yourapitoken'
    client.apps[0].remove_user 'email@xxx.xx'

list all teams

    require 'hockeyhelper'
    client = Hockey::Client.new 'yourapitoken'
    teams = client.teams

## Contributing

1. Fork it ( https://github.com/[my-github-username]/hockey/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
