module BitBucket
  module Error
    class BlankValue < ClientError
      def initialize(required_key)
        super "The value for: '#{required_key}', cannot be blank :("
      end
    end
  end
end
