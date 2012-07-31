# encoding: utf-8

module BitBucket #:nodoc
  # Raised when BitBucket returns the HTTP status code 422
  module Error
    class UnprocessableEntity < BitBucketError
      def initialize(env)
        super(env)
      end
    end
  end # Error
end # BitBucket
