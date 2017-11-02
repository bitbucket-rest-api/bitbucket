module BitBucket
  module Helpers
    module RepositoryHelper
      def sanitize_repository_name(repository_name)
        return if repository_name.nil?

        repository_name.downcase.
          gsub(/[^a-z0-9\_\-\.\/ ]/, '').
          gsub(/[ \/]/, '-').
          gsub(/-+/, '-')
      end
    end
  end
end
