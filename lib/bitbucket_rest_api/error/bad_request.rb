# encoding: utf-8

module BitBucket
  module Error
    # Raised when BitBucket returns the HTTP status code 400
    class BadRequest < ServiceError
      def initialize(env)
        super(env)
      end
    end
  end
end # BitBucket
