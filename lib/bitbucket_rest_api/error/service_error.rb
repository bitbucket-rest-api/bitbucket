# encoding: utf-8

module BitBucket #:nodoc
  # Raised when BitBucket returns any of the HTTP status codes
  module Error
    class ServiceError < BitBucketError
      attr_accessor :http_headers

      def initialize(env)
        super(generate_message(env))
        @http_headers = env[:response_headers]
      end

      def generate_message(env)
        "#{env[:method].to_s.upcase} #{env[:url].to_s}: #{env[:status]} #{env[:body]}"
      end
    end
  end # Error
end # BitBucket
