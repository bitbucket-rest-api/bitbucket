# encoding: utf-8

module BitBucket
  module Validations
    module Presence

      # Ensures that essential arguments are present before request is made
      #
      def _validate_presence_of(*params)
        params.each do |param|
          raise ArgumentError, "parameter cannot be nil" if param.nil?
        end
      end


      # Check if user or repository parameters are passed
      #
      def _validate_user_repo_params(user_name, repo_name)
        raise ArgumentError, "[user] parameter cannot be nil" if user_name.nil?
        raise ArgumentError, "[repo] parameter cannot be nil" if repo_name.nil?
      end

    end # Presence
  end # Validations
end # BitBucket
