# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require File.expand_path('../lib/bitbucket_rest_api/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'bitbucket_rest_api'
  gem.authors       = [ "Mike Cochran" ]
  gem.email         = "mcochran@linux.com"
  gem.homepage      = 'https://github.com/vongrippen/bitbucket'
  gem.summary       = %q{ Ruby wrapper for the BitBucket API supporting OAuth and Basic Authentication }
  gem.description   = %q{ Ruby wrapper for the BitBucket API supporting OAuth and Basic Authentication }
  gem.version       = BitBucket::VERSION::STRING.dup
  gem.license       = "MIT"

  gem.files = Dir['Rakefile', '{features,lib,spec}/**/*', 'README*', 'LICENSE*']
  gem.require_paths = %w[ lib ]

  gem.add_dependency 'hashie'
  gem.add_dependency 'faraday', '~> 0.9.0'
  gem.add_dependency 'multi_json',  '>= 1.7.5', '< 2.0'
  gem.add_dependency 'faraday_middleware', '~> 0.9.0'
  gem.add_dependency 'nokogiri', '>= 1.5.2'
  gem.add_dependency 'simple_oauth'

  gem.add_development_dependency 'rspec', '>= 0'
  gem.add_development_dependency 'rack-test'
  gem.add_development_dependency 'webmock', '~> 1.8.0'
  gem.add_development_dependency 'vcr', '~> 2.2.0'
  gem.add_development_dependency 'simplecov', '~> 0.6.1'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'bundler'
  gem.add_development_dependency 'pry-byebug'
  gem.add_development_dependency 'mocha'
end
