# BitBucketAPI

[![Gem Version](https://badge.fury.io/rb/bitbucket_rest_api.png)](http://badge.fury.io/rb/bitbucket_rest_api)

[Wiki](https://github.com/vongrippen/bitbucket/wiki) | [RDocs](http://rubydoc.info/github/vongrippen/bitbucket/master/frames)

A Ruby wrapper for the BitBucket REST API.

## Installation

Install the gem by issuing

```ruby
gem install bitbucket_rest_api
```

or put it in your Gemfile and run `bundle install`

```ruby
gem "bitbucket_rest_api"
```

## Usage

Create a new client instance

```ruby
bitbucket = BitBucket.new
```

At this stage you can also supply various configuration parameters, such as `:user`,`:repo`, `:oauth_token`, `:oauth_secret`, `:basic_auth` which are used throughout the API. These can be passed directly as hash options:

```ruby
bitbucket = BitBucket.new oauth_token: 'request_token', oauth_secret: 'request_secret'
```

Alternatively, you can configure the BitBucket settings by passing a block:

```ruby
bitbucket = BitBucket.new do |config|
  config.oauth_token   = 'request_token'
  config.oauth_secret  = 'request_secret'
  config.client_id     = 'consumer_key'
  config.client_secret = 'consumer_secret'
  config.adapter       = :net_http
end
```

You can authenticate either using OAuth authentication or through basic authentication by passing your login and password credentials

```ruby
bitbucket = BitBucket.new login:'vongrippen', password:'...'
```

or use convenience method:

```ruby
bitbucket = BitBucket.new basic_auth: 'login:password'
```

You can interact with BitBucket interface, for example repositories, by issuing following calls that correspond directly to the BitBucket API hierarchy

```ruby
bitbucket.repos.changesets.all  'user-name', 'repo-name'
bitbucket.repos.keys.list     'user-name', 'repo-name'
```

The response is of type [Hashie::Mash] and allows to traverse all the json response attributes like method calls.

## Inputs

Some API methods apart from required parameters such as username or repository name
allow you to switch the way the data is returned to you, for instance by passing
a block you can iterate over the list of repositories

```ruby
bitbucket.repos.list do |repo|
    puts repo.slug
end
```

## Advanced Configuration

The `bitbucket_rest_api` gem will use the default middleware stack which is exposed by calling `stack` on client instance. However, this stack can be freely modified with methods such as `insert`, `insert_after`, `delete` and `swap`. For instance to add your `CustomMiddleware` do

```ruby
bitbucket = BitBucket.new do |config|
  config.stack.insert_after BitBucket::Response::Helpers, CustomMiddleware
end
```

Furthermore, you can build your entire custom stack and specify other connection options such as `adapter`

```ruby
bitbucket = BitBucket.new do |config|
  config.adapter :excon

  config.stack do |builder|
    builder.use BitBucket::Response::Helpers
    builder.use BitBucket::Response::Jsonize
  end
end
```

## API

Main API methods are grouped into the following classes that can be instantiated on their own

```ruby
BitBucket         - full API access

BitBucket::Repos           BitBucket::Issues
```

Some parts of BitBucket API require you to be authenticated, for instance the following are examples of APIs only for the authenticated user

```ruby
BitBucket::Issues::Create
```

You can find out supported methods by calling `actions` on a class instance in your `irb`:

```ruby
>> BitBucket::Repos.actions                 >> bitbucket.issues.actions
---                                         ---
|--> all                                    |--> all
|--> branches                               |--> comments
|--> collaborators                          |--> create
|--> commits                                |--> edit
|--> contribs                               |--> events
|--> contributors                           |--> find
|--> create                                 |--> get
|--> downloads                              |--> labels
|--> edit                                   |--> list
|--> find                                   |--> list_repo
|--> forks                                  |--> list_repository
|--> get                                    |--> milestones
|--> hooks                                  ...
...
```

## Configuration

Certain methods require authentication. To get your BitBucket OAuth credentials,
register an app with BitBucket.

```ruby
BitBucket.configure do |config|
  config.oauth_token   = YOUR_OAUTH_REQUEST_TOKEN          # Different for each user
  config.oauth_secret  = YOUR_OAUTH_REQUEST_TOKEN_SECRET   # Different for each user
  config.client_id     = YOUR_OAUTH_CONSUMER_TOKEN
  config.client_secret = YOUR_OAUTH_CONSUMER_TOKEN_SECRET
  config.basic_auth    = 'login:password'
end

or

BitBucket.new(:oauth_token => YOUR_OAUTH_REQUEST_TOKEN, :oauth_secret => YOUR_OAUTH_REQUEST_TOKEN_SECRET)
BitBucket.new(:basic_auth => 'login:password')
```

## Development

Questions or problems? Please post them on the [issue tracker](https://bitbucket.com/vongrippen/bitbucket/issues). You can contribute changes by forking the project and submitting a pull request. You can ensure the tests are passing by running `bundle` and `rake`.

## Copyright

Copyright (c) 2012 James M Cochran.
Original github_api gem Copyright (c) 2011-2012 Piotr Murach. See LICENSE.txt for further details.
