# encoding: utf-8

module BitBucket
  module Error
    class BitBucketError < StandardError
      attr_reader :response_message, :response_headers

      def initialize(message)
        super message
        @response_message = message
      end

#       def inspect
#         %(#<#{self.class}>)
#       end
    end
  end # Error
end # BitBucket

%w[
  service_error
  not_found
  forbidden
  bad_request
  unauthorized
  service_unavailable
  internal_server_error
  unprocessable_entity
  client_error
  invalid_options
  required_params
  unknown_value
  bad_events
  no_events
  blank_value
].each do |error|
  require "bitbucket_rest_api/error/#{error}"
end
