# encoding: utf-8

require 'bitbucket_rest_api/core_ext/hash'

module BitBucket
  class ApiFactory

    # Instantiates a new bitbucket api object
    def self.new(klass, options={})
      return create_instance(klass, options) if klass
      raise ArgumentError, 'must provide klass to be instantiated'
    end

    # Passes configuration options to instantiated class
    def self.create_instance(klass, options)
      options.symbolize_keys!
      instance = convert_to_constant(klass.to_s).new options
      BitBucket.api_client = instance
      instance
    end

    def self.convert_to_constant(classes)
      constant = BitBucket
      classes.split('::').each do |klass|
        constant = constant.const_get klass
      end
      return constant
    end
  end
end # BitBucket
