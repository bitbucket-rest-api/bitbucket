# encoding: utf-8

module BitBucket
  module Validations
    module Required

      # Validate all keys present in a provided hash against required set,
      # on mismatch raise BitBucket::Error::RequiredParams
      # Note that keys need to be in the same format i.e. symbols or strings,
      # otherwise the comparison will fail.
      #
      def assert_required_keys(required, provided)
        result = required.all? do |key|
          provided.has_deep_key? key
        end
        if !result
          raise BitBucket::Error::RequiredParams.new(provided, required)
        end
        result
      end

      # Validate that required values are not blank
      # the *required are colon separated strings
      # e.g. 'source:branch:name' tests value of params[:source][:branch][:name]
      #
      def assert_required_values_present(params, *required)
        required.each do |encoded_string|
          keys = parse_values(encoded_string)
          value = keys.inject(params) { |params, key| params[key] }
          if value.is_a?(String)
            if value.empty?
              raise BitBucket::Error::BlankValue.new(encoded_string)
            end
          end
        end
      end

      def parse_values(string)
        string.split(':')
      end

    end # Required
  end # Validations
end # BitBucket
