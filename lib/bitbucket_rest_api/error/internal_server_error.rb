# encoding: utf-8

module BitBucket #:nodoc
  # Raised when BitBucket returns the HTTP status code 500
  module Error
    class InternalServerError < BitBucketError
      def initialize(env)
        super(env)
      end
    end
  end # Error
end # BitBucket
