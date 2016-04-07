# -*- encoding: utf-8 -*-

require 'bitbucket_rest_api/configuration'
require 'bitbucket_rest_api/connection'
require 'bitbucket_rest_api/validations'
require 'bitbucket_rest_api/request'
require 'bitbucket_rest_api/core_ext/hash'
require 'bitbucket_rest_api/core_ext/array'
require 'bitbucket_rest_api/api/actions'
require 'bitbucket_rest_api/api_factory'

module BitBucket
  class API
    include Authorization
    include Connection
    include Request

    # TODO consider these optional in a stack
    include Validations
    include ParameterFilter
    include Normalizer

    attr_reader *Configuration::VALID_OPTIONS_KEYS

    attr_accessor *VALID_API_KEYS

    # Callback to update global configuration options
    class_eval do
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        define_method "#{key}=" do |arg|
          self.instance_variable_set("@#{key}", arg)
          BitBucket.send("#{key}=", arg)
        end
      end
    end

    # Creates new API
    def initialize(options={}, &block)
      super()
      setup options
      set_api_client

      self.instance_eval(&block) if block_given?
    end

    def setup(options={})
      options = BitBucket.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
      process_basic_auth(options[:basic_auth])
    end

    # Extract login and password from basic_auth parameter
    def process_basic_auth(auth)
      case auth
      when String
        self.login, self.password = auth.split(':', 2)
      when Hash
        self.login    = auth[:login]
        self.password = auth[:password]
      end
    end

    # Assigns current api class
    def set_api_client
      BitBucket.api_client = self
    end

    # Responds to attribute query or attribute clear
    def method_missing(method, *args, &block) # :nodoc:
      case method.to_s
      when /^(.*)\?$/
        return !self.send($1.to_s).nil?
      when /^clear_(.*)$/
        self.send("#{$1.to_s}=", nil)
      else
        super
      end
    end

    def update_and_validate_user_repo_params(user_name, repo_name=nil)
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
    end

    def _update_user_repo_params(user_name, repo_name=nil) # :nodoc:
      self.user = user_name || self.user
      self.repo = repo_name || self.repo
    end

    def _merge_user_into_params!(params)  #  :nodoc:
      params.merge!({ 'user' => self.user }) if user?
    end

    def _merge_user_repo_into_params!(params)   #  :nodoc:
      { 'user' => self.user, 'repo' => self.repo }.merge!(params)
    end

    def _merge_mime_type(resource, params) # :nodoc:
                                           #       params['resource'] = resource
                                           #       params['mime_type'] = params['mime_type'] || :raw
    end

  end # API
end # BitBucket
