# encoding: utf-8

module BitBucket #:nodoc
  # Raised when passed parameters are missing or contain wrong values.
  module Error
    class Validations < ClientError
      def initialize(errors)
        super(
          generate_message(
            :problem => '',
            :summary => '',
            :resolution => ''
          )
        )
      end
    end
  end # Error
end # BitBucket
