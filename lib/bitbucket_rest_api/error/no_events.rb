module BitBucket
  module Error
    class NoEvents < ClientError
      def initialize
        super "At least one event is required, none given :("
      end
    end
  end
end
