# encoding: utf-8

require 'bitbucket_rest_api/version'
require 'bitbucket_rest_api/configuration'
require 'bitbucket_rest_api/constants'
require 'bitbucket_rest_api/utils/url'
require 'bitbucket_rest_api/connection'
require 'bitbucket_rest_api/deprecation'

module BitBucket
  extend Configuration

  class << self

    # Handle for the client instance
    attr_accessor :api_client

    # Alias for BitBucket::Client.new
    #
    # @return [BitBucket::Client]
    def new(options = { }, &block)
      @api_client = BitBucket::Client.new(options, &block)
    end

    # Delegate to BitBucket::Client
    #
    def method_missing(method, *args, &block)
      return super unless new.respond_to?(method)
      new.send(method, *args, &block)
    end

    def respond_to?(method, include_private = false)
      new.respond_to?(method, include_private) || super(method, include_private)
    end

  end

  module AutoloadHelper

    def autoload_all(prefix, options)
      options.each do |const_name, path|
        autoload const_name, File.join(prefix, path)
      end
    end

    def register_constant(options)
      options.each do |const_name, value|
        const_set const_name.upcase.to_s, value
      end
    end

    def lookup_constant(const_name)
      const_get const_name.upcase.to_s
    end

  end

  extend AutoloadHelper

  autoload_all 'bitbucket_rest_api',
               :API             => 'api',
               :ApiFactory      => 'api_factory',
               :Authorization   => 'authorization',
               :Authorizations  => 'authorizations',
               :Validations     => 'validations',
               :ParameterFilter => 'parameter_filter',
               :Normalizer      => 'normalizer',
               :Client          => 'client',
               :CoreExt         => 'core_ext',
               :Request         => 'request',
               :Response        => 'response',
               :Result          => 'result',

               :Repos           => 'repos',
               #:Error           => 'error',
               :Issues          => 'issues',
               :User            => 'user',
               :Users           => 'users',
               :Invitations     => 'invitations',
               :Teams           => 'teams'

  #:Teams           => 'teams',
  #:PullRequests    => 'pull_requests',
  #:Users           => 'users',
  #:Events          => 'events',
  #:Search          => 'search',
  #:PageLinks       => 'page_links',
  #:PageIterator    => 'page_iterator',
  #:PagedRequest    => 'paged_request'

end # BitBucket
