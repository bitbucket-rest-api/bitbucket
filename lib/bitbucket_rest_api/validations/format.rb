# encoding: utf-8

module BitBucket
  module Validations
    module Format

      # Ensures that value for a given key is of the correct form whether
      # matching regular expression or set of predefined values.
      #
      def assert_valid_values(permitted, params)
        params.each do |k, v|
          next unless permitted.keys.include?(k)
          if permitted[k].is_a?(Array) && !permitted[k].include?(params[k])
            raise BitBucket::Error::UnknownValue.new(k,v, permitted[k].join(', '))

          elsif permitted[k].is_a?(Regexp) && !(permitted[k] =~ params[k])
            raise BitBucket::Error::UnknownValue.new(k,v, permitted[k])
          end
        end
      end

    end # Format
  end # Validations
end # BitBucket
