module BitBucket
  module Error
    class BadEvents < ClientError
      def initialize(event)
        super "The event: '#{event}', does not exist :("
      end
    end
  end
end
